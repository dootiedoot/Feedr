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
    @IBOutlet weak var img_RecipeThumbnail: UIImageView!
    @IBOutlet weak var lbl_title: UINavigationItem!
    
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
						self.img_RecipeThumbnail.image = UIImage(data: data!)
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
