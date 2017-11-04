//
//  RecipeScreenViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/17/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class RecipeDetailVC: UIViewController
{
    //  CLASS VARIABLES
    var match = Match()
	var recipe = Recipe()
	
	var this_user_id = -1
	
    //  OUTLET VARIABLES
	@IBOutlet weak var img_recipeThumbnail: UIImageView!
	@IBOutlet weak var lbl_title: UINavigationItem!
	@IBOutlet weak var lbl_cookingTime: UILabel!
	@IBOutlet weak var lbl_ingredients: UILabel!
	@IBOutlet weak var lbl_flavor_piquant: UILabel!
	@IBOutlet weak var lbl_flavor_bitter: UILabel!
	@IBOutlet weak var lbl_flavor_sweet: UILabel!
	@IBOutlet weak var lbl_flavor_meaty: UILabel!
	@IBOutlet weak var lbl_flavor_salty: UILabel!
	@IBOutlet weak var lbl_flavor_sour: UILabel!
	@IBOutlet weak var lbl_servings: UILabel!
	@IBOutlet weak var lbl_holidays: UILabel!
	@IBOutlet weak var lbl_courses: UILabel!
	@IBOutlet weak var lbl_cuisines: UILabel!
	@IBOutlet weak var lbl_ratings: UILabel!
	
    @IBAction func btn_RecipeWebsite(_ sender: Any)
    {
        self.performSegue(withIdentifier: "RecipeWebsite", sender: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //print(match)
		
		YummlyAPI.GetRecipe(recipeID: match.id!)
		{ recipe in
			self.recipe = recipe
			
			//  Update title
			self.lbl_title.title = recipe.name!
			
			//  Load picture in thumbnail
			let url = URL(string: recipe.images![0].hostedLargeUrl!)
			URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
				if error != nil
				{
					print(error!)
					return
				}
				DispatchQueue.main.async
					{
						self.img_recipeThumbnail.image = UIImage(data: data!)
				}
			}).resume()
			
			//	Update everything inside main
			DispatchQueue.main.async
			{
				//	Display Ingredient lines
				var ingredientLines = "Ingredients:"
				for ingredientLine in recipe.ingredientLines!
				{
					ingredientLines += "\n\t" + ingredientLine
				}
				self.lbl_ingredients.text = ingredientLines
				
				//	Display flavors
				self.lbl_flavor_piquant.text = "Piuant: " + String(recipe.flavors!.Piquant!)
				self.lbl_flavor_bitter.text = "Bitter: " + String(recipe.flavors!.Bitter!)
				self.lbl_flavor_sweet.text = "Sweet: " + String(recipe.flavors!.Sweet!)
				self.lbl_flavor_meaty.text = "Meaty: " + String(recipe.flavors!.Meaty!)
				self.lbl_flavor_salty.text = "Salty: " + String(recipe.flavors!.Salty!)
				self.lbl_flavor_sour.text = "Sour: " + String(recipe.flavors!.Sour!)
				
				//	Display cooking time
				self.lbl_cookingTime.text = recipe.GetCookingTime()
				
				//	Display servings
				self.lbl_servings.text = "Servings: "+String(recipe.numberOfServings!)
				
				//	Display rating
				self.lbl_ratings.text = "Rating: "+String(recipe.rating!)
				
				//	Display cuisines
				var cuisinesLine = "Cuisine(s)"
				if recipe.attributes.cuisine != nil
				{
					for cuisine in recipe.attributes.cuisine!
					{
						cuisinesLine += "\n\t" + cuisine
					}
					self.lbl_cuisines.text = cuisinesLine
				}
				else
				{
					self.lbl_cuisines.isHidden = true
				}
				
				//	Display courses
				var coursesLine = "Course(s)"
				if recipe.attributes.course != nil
				{
					for course in recipe.attributes.course!
					{
						coursesLine += "\n\t" + course
					}
					self.lbl_courses.text = coursesLine
				}
				else
				{
					self.lbl_courses.isHidden = true
				}
				
				//	Display holidays
				var holidysLine = "Holidy(s)"
				if recipe.attributes.holiday != nil
				{
					for holiday in recipe.attributes.holiday!
					{
						holidysLine += "\n\t" + holiday
					}
					self.lbl_holidays.text = holidysLine
				}
				else
				{
					self.lbl_holidays.isHidden = true
				}
			}
			
			
		}
    }
	
	@IBAction func RecipeFav(_ sender: Any)
	{
		print(recipe.id!)
		
		addRecipeAsFav(user_id: this_user_id, recipe_id: recipe.id!)
	}
	func addRecipeAsFav(user_id:Int, recipe_id:String)
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
					print("Value Inserted")
				}
				else
				{
					print("Value did not go through")
				}
				sqlite3_finalize(statement)
				
				var selectStatement : OpaquePointer? = nil
				let selectQuery = "SELECT * FROM favrecipes"
				if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
				{
					while sqlite3_step(selectStatement) == SQLITE_ROW
					{
						let queryResultCol1 = sqlite3_column_text(selectStatement, 1)
						let uid = String(cString: queryResultCol1!)
						
						let queryResultCol2 = sqlite3_column_text(selectStatement, 2)
						let rid = String(cString: queryResultCol2!)
						
						print("\(uid) \(rid)")
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "RecipeWebsite"
        {
            //  Cache the recipe detail controller and pass the data over
            let recipeSourceWebsiteVC = segue.destination as! RecipeSourceWebsiteVC
            recipeSourceWebsiteVC.url = recipe.source?.sourceRecipeUrl!
        }
        else
        {
            print("Could not find segue identifier")
        }
    }
}
