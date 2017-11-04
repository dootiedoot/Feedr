//
//  UserProfileViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/9/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

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
        
        print("FROM FIELDS -> \(Iname) \(Iusername) \(Ipassword) \(Iemail) \(Iphone)")
        insertIntoDB(name:Iname, username:Iusername, password:Ipassword, email:Iemail, phone:Iphone)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            if sqlStatus == SQLITE_OK
            {
                var statement: OpaquePointer? = nil
                let insertQuery = "INSERT INTO user (name, username, password, email, contact) VALUES ('\(name)', '\(username)', '\(password)', '\(email)', '\(phone)');"
                
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
                
                var selectStatement : OpaquePointer? = nil
                let selectQuery = "SELECT * FROM user"
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        let rowId = sqlite3_column_int(selectStatement, 0)
                        
                        let queryResultCol1 = sqlite3_column_text(selectStatement, 1)
                        let name = String(cString: queryResultCol1!)
                        
                        let queryResultCol2 = sqlite3_column_text(selectStatement, 2)
                        let username = String(cString: queryResultCol2!)
                        
                        let queryResultCol3 = sqlite3_column_text(selectStatement, 3)
                        let pass = String(cString: queryResultCol3!)
                        
                        let queryResultCol4 = sqlite3_column_text(selectStatement, 4)
                        let email = String(cString: queryResultCol4!)
                        
                        let queryResultCol5 = sqlite3_column_text(selectStatement, 5)
                        let phone = String(cString: queryResultCol5!)
                        
                        print("\(rowId) \(name) \(username) \(pass) \(email) \(phone)")
                    }
                }
                sqlite3_finalize(selectStatement)
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
