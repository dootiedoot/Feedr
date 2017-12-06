//
//  ProfileTabVC.swift
//  FeedrApp
//
//  Created by Navneet Pandey on 12/5/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class ProfileTabVC: UIViewController {
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    @IBAction func switch_gluten(_ sender: UISwitch){
        print("In Glutton")
        let item = findInAllergy(allergy_name: "Gluten")
        if sender.isOn
        {
            print("sender is On Now")
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            print("sender is Off Now")
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_peanut(_ sender: UISwitch) {
        let item = findInAllergy(allergy_name: "Peanut")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_seafood(_ sender: UISwitch) {
        let item = findInAllergy(allergy_name: "Seafood")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_sesame(_ sender: UISwitch) {
        let item = findInAllergy(allergy_name: "Sesame")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_soy(_ sender: UISwitch) {
        let item = findInAllergy(allergy_name: "Soy")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_dairy(_ sender: UISwitch) {
        let item = findInAllergy(allergy_name: "Diary")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_Egg(_ sender: UISwitch){
        let item = findInAllergy(allergy_name: "Egg")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_sulfite(_ sender: UISwitch) {
        let item = findInAllergy(allergy_name: "Sulfite")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_treenut(_ sender: UISwitch) {
        let item = findInAllergy(allergy_name: "TreeNut")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_wheat(_ sender: UISwitch) {
        let item = findInAllergy(allergy_name: "Wheat")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Allergy is ->")
        print(self.allergy)
        profileName.text = "Hello, " + User.curr_user_name
        
        profilepic.layer.borderWidth = 2
        profilepic.layer.masksToBounds = false
        profilepic.layer.borderColor = UIColor.black.cgColor
        profilepic.layer.cornerRadius = profilepic.frame.height/2
        profilepic.clipsToBounds = true
    }
    
    enum stringToEnum: String
    {
        case Gluten = "Gluten"
        case Peanut = "Peanut"
        case Diary = "Diary"
        case Soy = "Soy"
        case Seafood = "Seafood"
        case Sesame = "Sesame"
        case Sulfite = "Sulfite"
        case Wheat = "Wheat"
        case Egg = "Egg"
        case TreeNut = "TreeNut"
    }
    
    let allergy = Allergy.Gluten
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAsAllergies(uid:Int, aid:Int)
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
                let insertQuery = "INSERT INTO userallergies (user_id, allergy_id) VALUES ('\(uid)', '\(aid)');"
                
                sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil)
                if sqlite3_step(statement) == SQLITE_DONE
                {
                    print("Value Inserted " + String(aid) + "for" + String(uid))
                }
                else
                {
                    print("Value did not go through")
                }
                sqlite3_finalize(statement)
            }
        }
    }
    
    func removeAsAllergies(uid:Int, aid:Int)
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
                let insertQuery = "DELETE FROM userallergies WHERE user_id = '\(uid)' AND allergy_id='\(aid)'"
                
                sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil)
                if sqlite3_step(statement) == SQLITE_DONE
                {
                    print("Value Deleted \(String(aid)) for user \(String(uid))")
                }
                else
                {
                    print("Value could not be deleted")
                }
                sqlite3_finalize(statement)
            }
        }
    }
    
    func findInAllergy(allergy_name: String) -> Int
    {
        let fileManager =  FileManager.default
        var db : OpaquePointer? = nil
        var dbURl : NSURL? = nil
        var aid: String = "-1"
        
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
                let selectQuery = "SELECT * FROM allergies WHERE allergicfood = '\(allergy_name)';"
                
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        let queryResultCol1 = sqlite3_column_text(selectStatement, 0)
                        aid = String(cString: queryResultCol1!)
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }
        
        return Int(aid)!
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
