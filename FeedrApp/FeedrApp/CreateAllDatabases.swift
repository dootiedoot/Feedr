//
//  CreateAllDatabases.swift
//  FeedrApp
//
//  Created by Navneet Pandey on 10/30/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class CreateAllDatabases: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        createTables()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    print("Allergies Table Created")
                }
                
                let createUserAllergiesTableQuery = "CREATE TABLE IF NOT EXISTS userallergies (id Integer Primary Key AutoIncrement UNIQUE, user_id Integer, allergy_id Integer);"
                if sqlite3_exec(db, createUserAllergiesTableQuery, nil, nil, errMsg) == SQLITE_OK
                {
                    print("User Allergies Table Created")
                }
                
                let createFavTabelQuery = "CREATE TABLE IF NOT EXISTS favrecipes (id Integer Primary Key AutoIncrement UNIQUE, user_id Integer, recipe_id Text);"
                if sqlite3_exec(db, createFavTabelQuery, nil, nil, errMsg) == SQLITE_OK
                {
                    print("Fav Table Created")
                }
					
//                let foodItem = Array of Allergic food items
//                var statement: OpaquePointer? = nil
                // use a loop to iterate through array and add each item to the database
//                let insertQuery = "INSERT INTO Allergies(allergicfood) VALUES ('\(foodItem)');"
                
//                sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil)
//                if sqlite3_step(statement) == SQLITE_DONE
//                {
//                    print("Value Inserted")
//                }
//                else
//                {
//                    print("Value did not go through")
//                }
//                sqlite3_finalize(statement)
//
//                var selectStatement2 : OpaquePointer? = nil
//                let deleteuery = "DELETE * FROM user WHERE id > 0"
//                if sqlite3_prepare_v2(db, deleteuery, -1, &selectStatement2, nil) == SQLITE_OK
//                {
//                    print("Entries Deleted")
//                }
//                else
//                {
//                    print(sqlite3_prepare_v2(db, deleteuery, -1, &selectStatement2, nil))
//                    print("Entries still exist")
//                }
//                sqlite3_finalize(selectStatement2)
//                let createShopListTabelQuery = "CREATE TABLE IF NOT EXISTS Profile (id Integer Primary Key AutoIncrement UNIQUE int, name Text, username Text, password Text, email Text, allergy_id int, fav_id int, shop_id int);"
//                if sqlite3_exec(db, createFavTabelQuery, nil, nil, errMsg) == SQLITE_OK
//                {
//                    print("Shop List Table Created")
//                }
//                sqlite3_finalize(selectStatement)
                print("Done creating tables")
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
