//
//  FavoritesVC.swift
//  FeedrApp
//
//  Created by chad hoang on 11/19/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit


struct UserRecipe
{
    static var favRecipes = [Recipe]()
}

class FavoritesVC: UITableViewController
{
	static var favRecipes = [Recipe]()
	private var selectedRecipe = Recipe()
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
		//Looks for single or multiple taps.
		//let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
		
		//Uncomment the line below if you want the tap not not interfere and cancel other interactions.
		
		//tap.cancelsTouchesInView = false
		
		//view.addGestureRecognizer(tap)
		
		//	Populate the table view with data
		PopulateTable()
	}
	
	func PopulateTable()
	{
		print("Attempting to populate favorites view...")
		
        let favRecipeIDs = RecipeDetailVC.GetFavoriteRecipeIDs()
		
		//  Dispatch queue so table view is refreshed with data
		DispatchQueue.main.async
		{
			self.tableView.reloadData()
		}
	}
    
    static func addRecipeAsFav(user_id:Int, recipe_id:String)
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
                let insertQuery = "INSERT INTO favrecipes (user_id, recipe_id) VALUES ('\(user_id)', '\(recipe_id)');"
                
                sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil)
                if sqlite3_step(statement) == SQLITE_DONE
                {
                    print("Value Inserted -> " + recipe_id)
                }
                else
                {
                    print("Value did not go through")
                }
                sqlite3_finalize(statement)
            }
        }
    }
    
//    static func FindRecipeAsFav(user_id:Int, recipe_id:String)
//    {
//        let fileManager =  FileManager.default
//        var db : OpaquePointer? = nil
//        var dbURl : NSURL? = nil
//
//        do
//        {
//            let baseURL = try
//                fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            dbURl = baseURL.appendingPathComponent("swift.sqlite") as NSURL
//        }
//        catch
//        {
//            print("Error")
//        }
//
//        if let dbUrl = dbURl
//        {
//            let flags = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE
//            let sqlStatus = sqlite3_open_v2(dbURl?.absoluteString?.cString(using: String.Encoding.utf8), &db, flags, nil)
//
//            if sqlStatus == SQLITE_OK
//            {
//                var statement: OpaquePointer? = nil
//                let insertQuery = "SELECT * FROM favrecipes" // WHERE recipe_id = '\(recipe_id)'"
//
////                sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil)
//                if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK
//                {
//                    while sqlite3_step(statement) == SQLITE_ROW
//                    {
//                        let queryResultCol1 = sqlite3_column_text(statement, 0)
//                        var id = String(cString: queryResultCol1!)
//
//                        let queryResultCol2 = sqlite3_column_text(statement, 1)
//                        var uid = String(cString: queryResultCol2!)
//
//                        let queryResultCol3 = sqlite3_column_text(statement, 2)
//                        let rid = String(cString: queryResultCol3!)
//
//                        print("\(uid)  and  \(rid)")
//                    }
//
//                }
//                sqlite3_finalize(statement)
//            }
//        }
//    }
    
    static func removeRecipeAsFav(user_id:Int, recipe_id:String)
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
                let insertQuery = "DELETE FROM favrecipes WHERE recipe_id = '\(recipe_id)'"
                
                sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil)
                if sqlite3_step(statement) == SQLITE_DONE
                {
                    print("Value Deleted " + recipe_id)
                }
                else
                {
                    print("Value could not be deleted")
                }
                sqlite3_finalize(statement)
            }
        }
    }
    
	//	Global function to add a Recipe to favorites given a recipeID
    static func AddToFavorites(this_user_id: Int, id: String)
	{
		//	if the id doesnt exists in the favorites. Add it to array
		if !IsRecipeFavorited(id: id)
		{
			YummlyAPI.GetRecipe(recipeID: id)
			{	recipe in
				favRecipes.append(recipe)
                addRecipeAsFav(user_id: this_user_id, recipe_id: id)
				print(id, "has been added to favorites")
//                FindRecipeAsFav(user_id: this_user_id, recipe_id: id)
//                RecipeDetailVC.UpdateFavoriteButton(RecipeDetailVC)
			}
		}
		else
		{
			print(id,"is already favorited. Doing nothing.")
			return
		}
	}
	
	//	Global function to remove a Recipe to favorites given a recipeID
    static func RemoveFromFavorites(id: String, user_id: Int)
	{
		//	if the id exists in the favorites. Remove it from array
		if IsRecipeFavorited(id: id)
		{
            favRecipes = favRecipes.filter{$0.id != id}
            removeRecipeAsFav(user_id: user_id, recipe_id: id)
//            FindRecipeAsFav(user_id: user_id, recipe_id: id)
            print(id, "has been removed from favorites")
		}
		else
		{
			print(id, "does not exist in favorites. Doing nothing.")
			return
		}
	}
	
	static func IsRecipeFavorited(id: String) -> Bool
	{
//        let recipeFound = favRecipes.filter{$0.id == id}.count > 0
        let favRecipeIDs = RecipeDetailVC.GetFavoriteRecipeIDs()
        let recipeFound = favRecipeIDs.contains(where: {
            $0.range(of: id, options: .caseInsensitive) != nil
        })
        
		if recipeFound == true
		{
            print("\(id) was found")
			return true
		}
		else
		{
            print("\(id) was not found")
			return false
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int
	{
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		// #warning Incomplete implementation, return the number of rows
		return FavoritesVC.favRecipes.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		//  Initialize the variables to tags
		let img_recipeThumbnail = cell.viewWithTag(1) as! UIImageView
		let lbl_recipeName = cell.viewWithTag(2) as! UILabel
		//let lbl_cookingTime = cell.viewWithTag(3) as! UILabel
		
		//  Assign variables to actual values
		//  Image thumbnail (code is long because there needs to be a handler for when img download fails for whatever reason.)
        
        let favRecipeIDs = RecipeDetailVC.GetFavoriteRecipeIDs()
		if FavoritesVC.favRecipes[indexPath.row].images![0].hostedLargeUrl != nil
		{
			let url = URL(string: FavoritesVC.favRecipes[indexPath.row].images![0].hostedLargeUrl!)
			URLSession.shared.dataTask(with: url!, completionHandler:
			{ (data, reponse, error) in
				if error != nil
				{
					print(error!)
					return
				}
				DispatchQueue.main.async
				{
					//  Finally, assign the image if all is successful
					img_recipeThumbnail.image = UIImage(data: data!)
				}
			}).resume()
		}
		
		//  Recipe Name
		lbl_recipeName.text = FavoritesVC.favRecipes[indexPath.row].name
	
        //  Cooking Time
		//lbl_cookingTime.text = FavoritesVC.favRecipes[indexPath.row].GetCookingTime()
		
		return cell
	}
	
	/*override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
	return 80
	}*/
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		selectedRecipe = FavoritesVC.favRecipes[indexPath.row]
		self.performSegue(withIdentifier: "RecipeDetail", sender: self)
		print("Tapped on row ", indexPath.row)
	}
	
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
		if segue.identifier == "RecipeDetail"
		{
			//  Cache the recipe detail controller and pass the data over
			let RecipeDetailVC = segue.destination as! RecipeDetailVC
			RecipeDetailVC.recipeID = selectedRecipe.id!
			//RecipeDetailController.this_user_id = user_id
		}
		else
		{
			print("Could not find segue identifier")
		}
	}
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
}

