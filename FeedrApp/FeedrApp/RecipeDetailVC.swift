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
			
			//print(self.recipe)
			
			//  Update title
			self.lbl_title.title = recipe.name!
			
			print(recipe)
			
			//	Update everything inside main
			DispatchQueue.main.async
			{
				//	Display Ingredient lines
				var ingredientLines = ""
				for ingredientLine in recipe.ingredientLines!
				{
					ingredientLines += "\n" + ingredientLine
				}
				self.lbl_ingredients.text = ingredientLines
				
				//	Display flavors
				/*self.lbl_flavor_piquant.text = String(recipe.flavors!.piquant!)
				self.lbl_flavor_bitter.text = String(recipe.flavors!.bitter!)
				self.lbl_flavor_sweet.text = String(recipe.flavors!.sweet!)
				self.lbl_flavor_meaty.text = String(recipe.flavors!.meaty!)
				self.lbl_flavor_salty.text = String(recipe.flavors!.salty!)
				self.lbl_flavor_sour.text = String(recipe.flavors!.sour!)*/
				
				//	Display cooking time
				self.lbl_cookingTime.text = recipe.GetCookingTime()
				
				//	Display servings
				self.lbl_servings.text = String(recipe.numberOfServings!)
				
				//	Display rating
				self.lbl_ratings.text = String(recipe.rating!)
				
				//	Display cuisines
				var cuisinesLine = ""
				if recipe.attribute!.cuisine != nil
				{
					for cuisine in recipe.attribute!.cuisine!
					{
						cuisinesLine += "\n" + cuisine
					}
				}
				self.lbl_cuisines.text = cuisinesLine
				
				//	Display courses
				var coursesLine = ""
				if recipe.attribute!.course != nil
				{
					for course in recipe.attribute!.course!
					{
						coursesLine += "\n" + course
					}
				}
				self.lbl_cuisines.text = coursesLine
				
				//	Display holidays
				var holidysLine = ""
				if recipe.attribute!.holiday != nil
				{
					for holiday in recipe.attribute!.holiday!
					{
						holidysLine += "\n" + holiday
					}
				}
				self.lbl_cuisines.text = holidysLine
			}
			
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
