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
    
    @IBAction func btn_login(_ sender: Any)
    {
        let Iuname = textf_uname.text!
        let Ipassword = textf_pass.text!
        findInDb(uname: Iuname, password: Ipassword)
        
        //if (credentialsMatch == true)
        //{
            performSegue(withIdentifier: "torecipe", sender: self)
        //}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "torecipe")
        {
            print("Going To Recipe")
//            let navVC = segue.destination as! RecipeNavController
            let segueVar = segue.destination as! RecipeSearchVC
            segueVar.name = self.name
            segueVar.user_id = self.user_id
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        createTables()
        self.hideKeyboard()
    }
    
    override func viewDidLoad()
	{
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
		
		//	CHAD TESING
		//  if the lbl_searchbar isnt empty...
		/*YummlyAPI.GetSearch(
			search: "",
			requirePictures: true,
			allowedIngredients: ["garlic","butter"],
			excludedIngredients: ["mushrooms"],
			allowedAllergies: [],
			allowedDiet: [],
			allowedCuisines: [],
			excludedCuisines: [],
			allowedCourses: [],
			excludeCourses: [],
			allowedHoliday: [],
			excludeHoliday: [],
			maxTotalTimeInSeconds: -1,
			maxResults: 100)
		{ result in
			
			/*for match in result.matches!
			{
			//print (match.recipeName!)
			//print (match.smallImageUrls![0])
			}*/
			//print(result)
			//	Error handling. (Use a pop-up)
			if result.totalMatchCount! <= 0
			{
				print("No results found!")
				return
			}
			else
			{
				print(result.matches?.count)
				for match in result.matches!
				{
					print(match.recipeName)
				}
			}
		}*/
	}
    
    func createTables()
    {
        print("creating tables...")
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
                let errMsg: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? =  nil
                //                let SQLquery2 = "DROP TABLE IF EXISTS allergies"
                //                if sqlite3_exec(db, SQLquery2,nil, nil, errMsg) == SQLITE_OK
                //                {
                //                    print("Table Dropped - allergies")
                //                }
                //
                //                let SQLquery3 = "DROP TABLE IF EXISTS user"
                //                if sqlite3_exec(db, SQLquery3,nil, nil, errMsg) == SQLITE_OK
                //                {
                //                    print("Table Dropped - User")
                //                }
                
                //                let SQLquery4 = "DROP TABLE IF EXISTS favrecipes"
                //                if sqlite3_exec(db, SQLquery4,nil, nil, errMsg) == SQLITE_OK
                //                {
                //                    print("Table Dropped - favrecipes")
                //                }
                
                let createProfileTabelQuery = "CREATE TABLE IF NOT EXISTS user (id Integer Primary Key AutoIncrement UNIQUE, name Text, username Text, password Text, email Text, contact Integer);"
                if sqlite3_exec(db, createProfileTabelQuery, nil, nil, errMsg) == SQLITE_OK
                {
                    print("Profile Table Created/Exist")
                }
                
                let createAllergiesTabelQuery = "CREATE TABLE IF NOT EXISTS allergies (id Integer Primary Key AutoIncrement UNIQUE, allergicfood Integer);"
                if sqlite3_exec(db, createAllergiesTabelQuery, nil, nil, errMsg) == SQLITE_OK
                {
                    print("Allergies Table Created/Exist")
                }
                
                let createUserAllergiesTableQuery = "CREATE TABLE IF NOT EXISTS userallergies (id Integer Primary Key AutoIncrement UNIQUE, user_id Integer, allergy_id Integer);"
                if sqlite3_exec(db, createUserAllergiesTableQuery, nil, nil, errMsg) == SQLITE_OK
                {
                    print("User Allergies Table Created/Exist")
                }
                
                let createFavTabelQuery = "CREATE TABLE IF NOT EXISTS favrecipes (id Integer Primary Key AutoIncrement UNIQUE, user_id Integer, recipe_id Text);"
                if sqlite3_exec(db, createFavTabelQuery, nil, nil, errMsg) == SQLITE_OK
                {
                    print("Fav Table Created/Exist")
                }
                print("Done with this class")
            }
        }
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
                        
                        print("\(id) \(iname) \(pass)")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
