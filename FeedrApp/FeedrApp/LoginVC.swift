//
//  UserLoginViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/9/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

struct User
{
    static var curr_user_id: Int = 0
    static var curr_user_name: String = "N/A"
}

class LoginVC: UIViewController
{
    @IBOutlet weak var textf_uname: UITextField!
    @IBOutlet weak var textf_pass: UITextField!
    
    var credentialsMatch: Bool = false
    var name : String = ""
    var user_id = -1
    
    func insertIntoAllergyDB(food: String)
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
                var statement: OpaquePointer? = nil
                let insertQuery = "INSERT OR IGNORE INTO allergies (allergicfood) VALUES ('\(food)')"
                
                sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil)
                if sqlite3_step(statement) == SQLITE_DONE
                {
                    //print("Value Inserted")
                }
                else
                {
                    print("Value did not go through")
                }
                sqlite3_finalize(statement)
            }
        }
    }
    
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .cancel, handler: { _ in
            //self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_login(_ sender: Any)
    {
        let Iuname = textf_uname.text!
        let Ipassword = textf_pass.text!
        
        findInDb(uname: Iuname, password: Ipassword)
        if (credentialsMatch == true)
        {
            performSegue(withIdentifier: "torecipe", sender: self)
            
            //  (CHAD) Retrive favorites from database and populate the favorites array at start
            let recipeIDS = FavoritesVC.GetFavoriteRecipeIDsFromDatabase()
			for (index, recipeID) in recipeIDS.enumerated()
            {
                YummlyAPI.GetRecipe(recipeID: recipeID)
                {   recipe in
                    FavoritesVC.favRecipes.append(recipe)
                    print("Recipe found in user favorites: \(recipe.name)")
					
					//	Execuated when all recipes have been appended
					if index >= recipeIDS.count - 1
					{
						YummlyAPI.UpdateRecommendations()
					}
                }
            }
        }
        else
        {
            showAlert(title: "Login Failed", message: "Incorrect Credentials")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "torecipe")
        {
            print("Going To Recipe")
            let tabBarViewControllers = segue.destination as! TabBarController
            let nav = tabBarViewControllers.viewControllers![0] as! UINavigationController
            let destinationViewController = nav.topViewController as! RecipeSearchVC
            
            destinationViewController.name = name
            destinationViewController.user_id = user_id
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
        findInDb(uname: "1", password: "2")
        insertValuesIntoDB()
        self.hideKeyboard()
		
    }
    
    func insertValuesIntoDB()
    {
        insertIntoAllergyDB(food: "Gluten")
        insertIntoAllergyDB(food: "Peanut")
        insertIntoAllergyDB(food: "Seafood")
        insertIntoAllergyDB(food: "Sesame")
        insertIntoAllergyDB(food: "Soy")
        insertIntoAllergyDB(food: "Diary")
        insertIntoAllergyDB(food: "Egg")
        insertIntoAllergyDB(food: "Sulfite")
        insertIntoAllergyDB(food: "TreeNut")
        insertIntoAllergyDB(food: "Wheat")
    }
    
    override func viewDidLoad()
	{
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
                
//                let SQLquery5 = "DROP TABLE IF EXISTS userallergies"
//                if sqlite3_exec(db, SQLquery5,nil, nil, errMsg) == SQLITE_OK
//                {
//                    print("Table Dropped - allergies")
//                }
//
//                let SQLquery3 = "DROP TABLE IF EXISTS user"
//                if sqlite3_exec(db, SQLquery3,nil, nil, errMsg) == SQLITE_OK
//                {
//                    print("Table Dropped - User")
//                }
//
//                let SQLquery4 = "DROP TABLE IF EXISTS favrecipes"
//                if sqlite3_exec(db, SQLquery4,nil, nil, errMsg) == SQLITE_OK
//                {
//                    print("Table Dropped - favrecipes")
//                }
                
                let createProfileTabelQuery = "CREATE TABLE IF NOT EXISTS user (id Integer Primary Key AutoIncrement UNIQUE, name Text, username Text UNIQUE, password Text, email Text, contact Integer);"
                if sqlite3_exec(db, createProfileTabelQuery, nil, nil, errMsg) == SQLITE_OK
                {
                    print("Profile Table Created/Exist")
                }
                
                let createAllergiesTabelQuery = "CREATE TABLE IF NOT EXISTS allergies (id Integer Primary Key AutoIncrement UNIQUE, allergicfood String UNIQUE);"
                if sqlite3_exec(db, createAllergiesTabelQuery, nil, nil, errMsg) == SQLITE_OK
                {
                    print("Allergies Table Created/Exist")
                }
                
                let createUserAllergiesTableQuery = "CREATE TABLE IF NOT EXISTS userallergies (id Integer Primary Key AutoIncrement UNIQUE, user_id Integer, allergy_id Integer UNIQUE);"
                if sqlite3_exec(db, createUserAllergiesTableQuery, nil, nil, errMsg) == SQLITE_OK
                {
                    print("User Allergies Table Created/Exist")
                }
                
                let createFavTabelQuery = "CREATE TABLE IF NOT EXISTS favrecipes (id Integer Primary Key AutoIncrement UNIQUE, user_id Integer, recipe_id Text UNIQUE);"
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
                let selectQuery = "SELECT * FROM user" // WHERE username = '\(uname)'"
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    print("Check DB BC")
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        
                        let queryResultCol1 = sqlite3_column_text(selectStatement, 0)
                        var id = String(cString: queryResultCol1!)
                        
                        let queryResultCol2 = sqlite3_column_text(selectStatement, 1)
                        var iname = String(cString: queryResultCol2!)

                        let queryResultCol3 = sqlite3_column_text(selectStatement, 3)
                        let pass = String(cString: queryResultCol3!)
                        
                        let queryResultCol02 = sqlite3_column_text(selectStatement, 2)
                        let username = String(cString: queryResultCol02!)
                
                        //print("\(id) \(iname) \(username) \(pass)")
                        let queryResultCol4 = sqlite3_column_text(selectStatement, 4)
                        let email = String(cString: queryResultCol4!)

                        let queryResultCol5 = sqlite3_column_text(selectStatement, 5)
                        let phone = String(cString: queryResultCol5!)

                        print("\(iname) \(username) \(pass) \(email) \(phone)")
                        
                        if (username == uname && pass == password)
                        {
                            User.curr_user_id = Int(id)!
                            User.curr_user_name = iname
                            print("Check DB BC In")
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
