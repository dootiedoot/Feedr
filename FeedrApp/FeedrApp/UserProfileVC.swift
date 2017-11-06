//
//  UserProfileViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/9/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

class UserProfileVC: UIViewController
{
    var Iname:String = ""
    var Iusername:String = ""
    var Ipassword:String = ""
    var Iemail:String = ""
    var Iphone:String = ""
    
    @IBOutlet weak var textf_name: UITextField!
    @IBOutlet weak var textf_uname: UITextField!
    @IBOutlet weak var textf_pass: UITextField!
    @IBOutlet weak var textf_email: UITextField!
    @IBOutlet weak var textf_phone: UITextField!
    
    @IBAction func btn_register(_ sender: Any)
    {
        Iname = textf_name.text!
        Iusername = textf_uname.text!
        Ipassword = textf_pass.text!
        Iemail = textf_email.text!
        Iphone = textf_phone.text!
        
        if (Iname == "" || Iusername == "" || Ipassword == "" || Iemail == "" || Iphone == "")
        {
            guard !Iname.isEmpty else {
               showAlert(title: "Name cannot be empty", message: "Please enter your name")
                return
                }
            guard !Iusername.isEmpty else {
            showAlert(title: "Username cannot be empty", message: "Please enter username")
            return
                }
            guard !Ipassword.isEmpty else {
                self.showAlert(title: "Password cannot be empty", message: "Please enter a password")
                return
                }
            guard !Iemail.isEmpty else {
                showAlert(title: "Email cannot be empty", message: "Please enter your email")
                return
                }
            guard !Iphone.isEmpty else {
                showAlert(title: "Phone Number cannot be empty", message: "Please enter your phone number")
                return
                }
        }
        else
        {
            if (isValidEmail(email: Iemail))
            {
                if (isValidPhone(phone:Iphone))
                {
                    insertIntoDB(name: Iname, username: Iusername, password: Ipassword, email: Iemail, phone: Iphone)
                    performSegue(withIdentifier: "tologin", sender: self)
                }
                else
                {
                    showAlert(title: "Invalid Phone Number", message: "Please verify your phone number")
                }
            }
            else
            {
                showAlert(title: "Invalid Email", message: "Please verify your email")
            }
        }
    }
    
    func isValidEmail(email:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailVal = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailVal.evaluate(with: email)
    }
    
    func isValidPhone(phone:String) -> Bool
    {
        let phone_regex = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phone_regex)
        let result =  phoneTest.evaluate(with: phone)
        return result
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .cancel, handler: { _ in
//            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "tologin")
        {
            let segueVar = segue.destination as! LoginVC
        }
    }
    
    func insertIntoDB(name:String, username:String, password:String, email:String, phone:String)
    {
        let fileManager =  FileManager.default
        var db : OpaquePointer? = nil
        var dbURl : NSURL? = nil
        
        do
        {
            let baseURL = try
                fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            dbURl = baseURL.appendingPathComponent("swift.sqlite") as NSURL
        }
        catch
        {
            print("Error")
        }
        
        if let dbUrl = dbURl
        {
            let flags = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE
            let sqlStatus = sqlite3_open_v2(dbURl?.absoluteString?.cString(using: String.Encoding.utf8), &db, flags, nil)
            
            var insert_flag = true
            if sqlStatus == SQLITE_OK
            {
                var selectStatement : OpaquePointer? = nil
                let selectQuery =  "SELECT * FROM user WHERE username = '\(username)'"
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        let queryResultCol2 = sqlite3_column_text(selectStatement, 2)
                        let currusername = String(cString: queryResultCol2!)
                        
                        print("Username is \(username)")
                        
                        if (currusername == username)
                        {
                            insert_flag = false
                        }
                    }
                }
                sqlite3_finalize(selectStatement)
                
                print(insert_flag)
                if (insert_flag == true)
                {
                    var statement: OpaquePointer? = nil
                    let insertQuery = "INSERT OR IGNORE INTO user (name, username, password, email, contact) VALUES ('\(name)', '\(username)', '\(password)', '\(email)', '\(phone)');"
                    
                    sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil)
                    if sqlite3_step(statement) == SQLITE_DONE
                    {
                        print("Value Inserted")
                    }
                    else
                    {
                        print("Value did not go through")
                    }
                    sqlite3_finalize(statement)
//
//                    var selectStatement2 : OpaquePointer? = nil
//                    var selectQuery2 = "SELECT * FROM user"
//                    if sqlite3_prepare_v2(db, selectQuery2, -1, &selectStatement2, nil) == SQLITE_OK
//                    {
//                        while sqlite3_step(selectStatement2) == SQLITE_ROW
//                        {
//                            let rowId = sqlite3_column_int(selectStatement2, 0)
//
//                            let queryResultCol1 = sqlite3_column_text(selectStatement2, 1)
//                            let name = String(cString: queryResultCol1!)
//
//                            let queryResultCol2 = sqlite3_column_text(selectStatement2, 2)
//                            let username = String(cString: queryResultCol2!)
//
//                            let queryResultCol3 = sqlite3_column_text(selectStatement2, 3)
//                            let pass = String(cString: queryResultCol3!)
//
//                            let queryResultCol4 = sqlite3_column_text(selectStatement2, 4)
//                            let email = String(cString: queryResultCol4!)
//
//                            let queryResultCol5 = sqlite3_column_text(selectStatement2, 5)
//                            let phone = String(cString: queryResultCol5!)
//
//                            print("\(rowId) \(name) \(username) \(pass) \(email) \(phone)")
//                        }
//                    }
//                    sqlite3_finalize(selectStatement2)
                    performSegue(withIdentifier: "tologin", sender: self)
                }
                else
                {
                    showAlert(title: "username already exists", message:"please try again")
                    insert_flag = true
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
