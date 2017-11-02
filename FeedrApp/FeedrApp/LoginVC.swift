//
//  UserLoginViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/9/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class LoginVC: UIViewController
{
    @IBOutlet weak var textf_uname: UITextField!
    @IBOutlet weak var textf_pass: UITextField!
    var credentialsMatch: Bool = false
    var name : String = ""
    var user_id = -1
    
    @IBAction func LoginCheck(_ sender: Any)
    {
        let Iuname = textf_uname.text!
        let Ipassword = textf_pass.text!
        textf_pass.resignFirstResponder()
        findInDb(uname: Iuname, password: Ipassword)
        
        if (credentialsMatch == true)
        {
            performSegue(withIdentifier: "torecipe", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "torecipe")
        {
//            let navVC = segue.destination as! RecipeNavController
            let segueVar = segue.destination as! RecipeSearchVC
            segueVar.name = self.name
            segueVar.user_id = self.user_id
        }
    }
    
    override func viewDidLoad()
	{
        self.hideKeyboard()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func findInDb(uname:String, password:String)
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
                var selectStatement : OpaquePointer? = nil
                let selectQuery = "SELECT * FROM user WHERE username = '\(uname)'"
                //(uname.trimmingCharacters(in: .whitespacesAndNewlines))
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        let queryResultCol1 = sqlite3_column_text(selectStatement, 0)
                        var id = String(cString: queryResultCol1!)
                        
                        let queryResultCol2 = sqlite3_column_text(selectStatement, 1)
                        var iname = String(cString: queryResultCol2!)

                        let queryResultCol3 = sqlite3_column_text(selectStatement, 3)
                        let pass = String(cString: queryResultCol3!)

//                        let queryResultCol1 = sqlite3_column_text(selectStatement, 1)
//                        let name = String(cString: queryResultCol1!)
//
//                        let queryResultCol2 = sqlite3_column_text(selectStatement, 2)
//                        let username = String(cString: queryResultCol2!)
//
//                        let queryResultCol3 = sqlite3_column_text(selectStatement, 3)
//                        let pass = String(cString: queryResultCol3!)
//
//                        let queryResultCol4 = sqlite3_column_text(selectStatement, 4)
//                        let email = String(cString: queryResultCol4!)
//
//                        let queryResultCol5 = sqlite3_column_text(selectStatement, 5)
//                        let phone = String(cString: queryResultCol5!)

//                        print("\(username.count)")
//                        print("\(name) \(username) \(pass) \(email) \(phone)")
                        
                        if (pass == password)
                        {
                            self.credentialsMatch = true
                            self.name = iname
                            self.user_id = Int(id)!
                        }
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
