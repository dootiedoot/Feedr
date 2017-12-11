//
//  ResetPassowrdVC.swift
//  FeedrApp
//
//  Created by Navneet Pandey on 12/11/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit
import MessageUI

class ResetPassowrdVC: UIViewController, MFMessageComposeViewControllerDelegate
{
    @IBOutlet weak var text_code: UITextField!
    @IBOutlet weak var text_username: UITextField!
    @IBOutlet weak var text_passNew: UITextField!
    @IBOutlet weak var text_passConf: UITextField!
    
    var phNo = ""
    var randCode = ""
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
//        randCode = randomCodeGen(digits: 4)
//        phNo = getPhoneNumber()
//        messageMe(msg: randCode, phone: phNo)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
//        while !isPassCodeCorrect(randCode: randCode)
//        {
//            showAlert(title: "Wrong Code", message: "Please Enter the correct code")
//        }
    }
    
    @IBAction func ChangePassword(_ sender: UIButton)
    {
        if text_passNew.text! != text_passConf.text!
        {
            showAlert(title: "Passwords Don't Match", message: "Check Both Entries")
        }
        else
        {
            updatePassword()
        }
    }
    
    func updatePassword()
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
                let updateQuery = "UPDATE user SET password = \(text_passNew.text!.trimmingCharacters(in: .whitespacesAndNewlines)) WHERE username = \(text_username.text!)"
//                let updateQuery = "UPDATE user SET password = 2 WHERE username = 1"
                if sqlite3_prepare_v2(db, updateQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    if sqlite3_step(selectStatement) == SQLITE_DONE
                    {
                        print("Successfully update row.")
                        //getPhoneNumber()
                        showAlert(title: "Password Updated", message: "Remember The Password This Time")
                    }
                    else
                    {
                        print("Could not update row.")
                    }
                }
                else
                {
                    print("Ghanta")
                }
                sqlite3_finalize(selectStatement)
            }
        }
    }
    
    func getPhoneNumber() -> String
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
                let selectQuery = "SELECT * FROM user"
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        let queryResultCol1 = sqlite3_column_text(selectStatement, 0)
                        var id = String(cString: queryResultCol1!)
                        
                        let queryResultCol2 = sqlite3_column_text(selectStatement, 1)
                        var iname = String(cString: queryResultCol2!)
                        
                        let queryResultCol3 = sqlite3_column_text(selectStatement, 2)
                        let username = String(cString: queryResultCol3!)
                        
                        let queryResultCol4 = sqlite3_column_text(selectStatement, 3)
                        let password = String(cString: queryResultCol4!)
                        
                        let queryResultCol5 = sqlite3_column_text(selectStatement, 5)
                        let phone = String(cString: queryResultCol5!)
                        
                        print("\(iname) \(username) \(password) \(phone)")
                        if iname == text_username.text!
                        {
                            return phone
                        }
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }
        return ""
    }
    
    func isPassCodeCorrect(randCode: String) -> Bool
    {
        if text_code.text! == randCode
        {
            text_passNew.isEnabled = true
            text_passConf.isEnabled = false
            return true
        }
        else
        {
            return false
        }
    }
    
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func randomCodeGen(digits:Int) -> String {
        var number = ""
        for i in 0..<digits
        {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0
            {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        
        
        return number
    }
    
    func messageMe(msg: String, phone: String)
    {
        if MFMessageComposeViewController.canSendText(){
            let msgSender = MFMessageComposeViewController()
            msgSender.body = msg
            msgSender.recipients = ["8329039754"]
            msgSender.messageComposeDelegate = self
            self.present(msgSender, animated: true, completion: nil)
        }
        else
        {
            print("I am sorry, can't send the message")
        }
    }

    override func didReceiveMemoryWarning() {
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
