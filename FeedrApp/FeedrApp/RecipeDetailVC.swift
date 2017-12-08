//
//  RecipeScreenViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/17/17.
//  Copyright © 2017 Team9. All rights reserved.
//	

import UIKit
import DDSpiderChart

class RecipeDetailVC: UIViewController
{
    //  CLASS VARIABLES
	var recipeID : String = ""
    var ratingImageName: String = ""
	private var recipe = Recipe()
	var this_user_id = -1
    
    @IBOutlet weak var flavorChart: DDSpiderChartView!
    @IBOutlet weak var Image_rating: UIImageView!
    //  OUTLET VARIABLES
	@IBOutlet weak var img_recipeThumbnail: UIImageView!
	@IBOutlet weak var lbl_title: UINavigationItem!
	@IBOutlet weak var lbl_cookingTime: UILabel!
	@IBOutlet weak var lbl_ingredients: UILabel!
    
	@IBOutlet weak var lbl_servings: UILabel!
	@IBOutlet weak var lbl_holidays: UILabel!
	@IBOutlet weak var lbl_courses: UILabel!
	@IBOutlet weak var lbl_cuisines: UILabel!
	@IBOutlet weak var btn_Favorite: UIButton!
    @IBOutlet weak var btn_cook: UIButton!
    
	@IBAction func btn_RecipeWebsite(_ sender: Any)
    {
        self.performSegue(withIdentifier: "RecipeWebsite", sender: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btn_Favorite.layer.cornerRadius = 4
        btn_cook.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
        print("\(this_user_id) \(recipeID)")
		PopulateView()
    }
	
    //  Populate the view controller with data
	func PopulateView()
	{
		print("Populating recipe detail view...")
		
		YummlyAPI.GetRecipe(recipeID: recipeID)
		{	recipe in
			self.recipe = recipe
			
			//  Update title
			self.lbl_title.title = recipe.name!
			
			//  Load picture in thumbnail
			let url = URL(string: recipe.images![0].hostedLargeUrl!)
			URLSession.shared.dataTask(with: url!, completionHandler:
				{ (data, response, error) in
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
				for ingredientLine in self.recipe.ingredientLines!
				{
					ingredientLines += "\n\t" + ingredientLine
				}
				self.lbl_ingredients.text = ingredientLines
                self.flavorChart.color = .darkGray
                
                var allflavorites = [Float]()
                var availibleFlavors = [String]()
                
				//	Display flavors
                if (self.recipe.flavors!.Piquant != nil && self.recipe.flavors!.Piquant! > Float(0.00))
				{
                    allflavorites.append(self.recipe.flavors!.Piquant!)
                    availibleFlavors.append("Piuant")
				}
				if (self.recipe.flavors!.Bitter != nil && self.recipe.flavors!.Bitter! > Float(0.00))
				{
                    allflavorites.append(self.recipe.flavors!.Bitter!)
                    availibleFlavors.append("Bitter")
				}
				if (self.recipe.flavors!.Sweet != nil && self.recipe.flavors!.Sweet! > Float(0.00))
				{
                    allflavorites.append(self.recipe.flavors!.Sweet!)
                    availibleFlavors.append("Sweet")
				}
				if (self.recipe.flavors!.Meaty != nil && self.recipe.flavors!.Meaty! > Float(0.00))
				{
                    allflavorites.append(self.recipe.flavors!.Meaty!)
                    availibleFlavors.append("Meaty")
				}
				if (self.recipe.flavors!.Salty != nil && self.recipe.flavors!.Salty! > Float(0.00))
				{
                    allflavorites.append(self.recipe.flavors!.Salty!)
                    availibleFlavors.append("Salty")
				}
				if (self.recipe.flavors!.Sour != nil && self.recipe.flavors!.Sour! > Float(0.00))
				{
                    allflavorites.append(self.recipe.flavors!.Sour!)
                    availibleFlavors.append("Sour")
				}
				
                if(allflavorites.isEmpty || availibleFlavors.isEmpty)
                {
                    self.flavorChart.isHidden = true;
                }
                else
                {
                    self.flavorChart.axes = availibleFlavors
                    self.flavorChart.addDataSet(values: allflavorites, color: .cyan)
                }
                
				//	Display cooking time
				self.lbl_cookingTime.text = self.recipe.GetCookingTime()
				
				//	Display servings
				self.lbl_servings.text = "Servings: "+String(self.recipe.numberOfServings!)
				
				//	Display rating
				//self.lbl_ratings.text = "Rating: "+String(self.recipe.rating!)
                
                self.ratingImageName = String(self.recipe.rating!)
                self.Image_rating.image = UIImage(named:self.ratingImageName)
                
				
				//	Display cuisines
				var cuisinesLine = "Cuisine(s)"
				if self.recipe.attributes.cuisine != nil
				{
					for cuisine in self.recipe.attributes.cuisine!
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
				if self.recipe.attributes.course != nil
				{
					for course in self.recipe.attributes.course!
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
				if self.recipe.attributes.holiday != nil
				{
					for holiday in self.recipe.attributes.holiday!
					{
						holidysLine += "\n\t" + holiday
					}
					self.lbl_holidays.text = holidysLine
				}
				else
				{
					self.lbl_holidays.isHidden = true
				}
				
				//	Update the favorite button status
				self.UpdateFavoriteButton()
			}
            
            
            //  Add to recipe history
            YummlyAPI.AddRecipeToHistory(recipe: self.recipe)
		}
	}
	
	//	Updates the favorite button if it is currently favorited or not.
	//	CHANGE CODE BELOW TO UPDATE VISUALS AND ICON
	func UpdateFavoriteButton()
	{
        //Duplicate check was cauing button change to only work once
        
		//	if the recipe is favorited...
        if FavoritesVC.IsRecipeFavorited(id: self.recipe.id!) == true
		{
			//	Update everything inside main
			self.btn_Favorite.setTitle("Remove from favorites", for: .normal)
			//print("button says remove to favorites")
		}
		else
		{
			self.btn_Favorite.setTitle("Add to favorites", for: .normal)
			//print("button says Add to favorites")
		}
	}
	
	@IBAction func OnFavoriteRecipe(_ sender: Any)
	{
		//print(self.recipe.id!)
		//addRecipeAsFav(user_id: this_user_id, recipe_id: recipe.id!)
		
		//	if the recipe is not favorited... Add to favorites. Else remove from favorites.
		if FavoritesVC.IsRecipeFavorited(id: self.recipe.id!) == false
		{
			FavoritesVC.AddToFavorites(this_user_id: this_user_id, id: self.recipe.id!)
			//	Due to loading issues. RecipeDetailVC.UpdateFavoriteButton() is called from FavoritesVC.AddToFavorites(...)
            self.btn_Favorite.setTitle("Remove from favorites", for: .normal)
            print("button says remove to favorites")
		}
		else
		{
            FavoritesVC.RemoveFromFavorites(id: self.recipe.id!, user_id: this_user_id)
            self.btn_Favorite.setTitle("Add to favorites", for: .normal)
            print("button says Add to favorites")
		}
        
        //    Update the favorite button status
//        UpdateFavoriteButton()
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
