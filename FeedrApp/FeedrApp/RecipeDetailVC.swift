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
    var recipe = Match()
    
    //  OUTLET VARIABLES
    @IBOutlet weak var img_RecipeThumbnail: UIImageView!
    @IBOutlet weak var lbl_title: UINavigationItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(recipe)
        
        //  Update title
        lbl_title.title = recipe.recipeName!
        
        //  Load picture in thumbnail
        let url = URL(string: recipe.smallImageUrls![0])
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

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
