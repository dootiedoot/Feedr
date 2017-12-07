//
//  ProfileTabVC.swift
//  FeedrApp
//
//  Created by Navneet Pandey on 12/5/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class ProfileTabVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!

    @IBOutlet weak var SwitchSoy: UISwitch!
    @IBOutlet weak var switchSesame: UISwitch!
    @IBOutlet weak var switchGluten: UISwitch!
    @IBOutlet weak var switchSeafood: UISwitch!
    @IBOutlet weak var switchPeanuts: UISwitch!
    @IBOutlet weak var SwitchDairy: UISwitch!
    @IBOutlet weak var SwitchEgg: UISwitch!
    @IBOutlet weak var SwitchSulfite: UISwitch!
    @IBOutlet weak var SwitchTreenut: UISwitch!
    @IBOutlet weak var SwitchWheat: UISwitch!
    
    let picker = UIImagePickerController()
    
    //  when the user taps the logout button...
    @IBAction func OnLogoutBtn(_ sender: UIButton)
    {
        //  Clear data
        FavoritesVC.favRecipes = [Recipe]()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        print("Selecting an Image")
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgView.contentMode = UIViewContentMode.scaleAspectFit
        print(chosenImage.imageOrientation)
        imgView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func switch_Gluten(_ sender: UISwitch)
    {
        let item = findInAllergy(allergy_name: "Gluten")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        }
        else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_Peanut(_ sender: UISwitch)
    {
        let item = findInAllergy(allergy_name: "Peanut")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_Seafood(_ sender: UISwitch)
    {
        let item = findInAllergy(allergy_name: "Seafood")
        if sender.isOn
        {
            addAsAllergies(uid: User.curr_user_id, aid: item)
        } else
        {
            removeAsAllergies(uid: User.curr_user_id, aid: item)
        }
    }
    
    @IBAction func switch_sesame(_ sender: UISwitch)
    {
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
        imgView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
//        print("Allergy is ->")
//        print(self.listAllergy)
        profileName.text = "Hello, " + User.curr_user_name
        
        picker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(popUpOnTap(gesture:)))
        tap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(tap)
        
        profilepic.layer.borderWidth = 2
        profilepic.layer.masksToBounds = false
        profilepic.layer.borderColor = UIColor.black.cgColor
        profilepic.layer.cornerRadius = profilepic.frame.height/2
        profilepic.clipsToBounds = true
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            present(picker,animated: true,completion: nil)
        }
        else {
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    func loadImageFromGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        }
        else {
            let alertVC = UIAlertController(title: "No Photo Library", message: "Sorry, this device does not have a supported photo library", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    @objc func popUpOnTap(gesture: UITapGestureRecognizer)
    {
        if gesture.state == .ended
        {
            let alert = UIAlertController(title: "Picker", message: "Choose One", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Open Camera", comment: "Default action"), style: .default, handler: { _ in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Open Gallery", comment: "Default action"), style: .default, handler: { _ in
                self.loadImageFromGallery()
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
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
    
    override func viewWillAppear(_ animated: Bool)
    {
        var listAllergy = findUserAllergies(uid: User.curr_user_id)
        print(listAllergy)
        for allergy in listAllergy
        {
            let allergyFound = listAllergy.contains(where: {
                $0.range(of: allergy, options: .caseInsensitive) != nil
            })
            
            if allergyFound == true
            {
                if allergy == "Gluten"
                {
                    switchGluten.setOn(true, animated: true)
                }
                else
                if allergy == "Peanut"
                {
                    switchPeanuts.setOn(true, animated: true)
                }
                else
                if allergy == "Seafood"
                {
                    switchSeafood.setOn(true, animated: true)
                }
                else
                if allergy == "Sesame"
                {
                    switchSesame.setOn(true, animated: true)
                }
                else
                if allergy == "Soy"
                {
                    SwitchSoy.setOn(true, animated: true)
                }
                else
                if allergy == "Diary"
                {
                    SwitchDairy.setOn(true, animated: true)
                }
                else
                if allergy == "Egg"
                {
                    SwitchEgg.setOn(true, animated: true)
                }
                else
                if allergy == "Sulfite"
                {
                    SwitchSulfite.setOn(true, animated: true)
                }
                else
                if allergy == "TreeNut"
                {
                    SwitchTreenut.setOn(true, animated: true)
                }
                else
                if allergy == "Wheat"
                {
                    SwitchWheat.setOn(true, animated: true)
                }
            }
        }
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
        print(findUserAllergies(uid: User.curr_user_id))
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
    
    func findAllergyName(allergy_id: Int) -> String
    {
        let fileManager =  FileManager.default
        var db : OpaquePointer? = nil
        var dbURl : NSURL? = nil
        //var aid: String = "-1"
        
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
        
        var allergyName = ""
        if let dbUrl = dbURl
        {
            let flags = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE
            let sqlStatus = sqlite3_open_v2(dbURl?.absoluteString?.cString(using: String.Encoding.utf8), &db, flags, nil)
            
            if sqlStatus == SQLITE_OK
            {
                var selectStatement : OpaquePointer? = nil
                let selectQuery = "SELECT * FROM allergies WHERE id = '\(allergy_id)';"
                
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        let queryResultCol1 = sqlite3_column_text(selectStatement, 1)
                        let aname = String(cString: queryResultCol1!)
                        allergyName = aname
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }
        return allergyName
    }
    
    func findUserAllergies(uid:Int) -> [String]
    {
        let fileManager =  FileManager.default
        var db : OpaquePointer? = nil
        var dbURl : NSURL? = nil
        var aid: String = "-1"
        var allergyIDs = [Int]()
        
        var userAllergies = [String]()
        
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
                let selectQuery = "SELECT * FROM userallergies WHERE user_id = '\(uid)'"
                
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        let queryResultCol = sqlite3_column_text(selectStatement, 2)
                        aid = String(cString: queryResultCol!)
        
                        let allergyName = findAllergyName(allergy_id: Int(aid)!)
                        userAllergies.append(allergyName)
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }
        return userAllergies
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
