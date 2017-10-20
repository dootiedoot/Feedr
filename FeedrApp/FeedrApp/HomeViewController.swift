//
//  HomeViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/9/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{
    
        //THIS IS THE SEARCH BAR AT THE TOP OF THE VIEW
    @IBOutlet var lbl_searchbar1: UITextField!
    
    @IBAction func Btn_Search1(_ sender: Any) {
        
                //WE NEED A CHECK HERE TO SEE IF THE Lbl_searchbar1 HAS THIS ITEM
        
        YummlyAPI.GetSearch(
            search: lbl_searchbar1.text!,//"soup",
            requirePictures: true,
            allowedIngredients: [],
            allowedAllergies: [],
            allowedDiet: [],
            allowedCuisines: [],
            excludedCuisines: [],
            allowedCourses: [],
            excludeCourses: [],
            allowedHoliday: [],
            excludeHoliday: [],
            maxTotalTimeInSeconds: -1,
            maxResults: -1)
        { result in
            
            for match in result.matches!
            {
                print (match.recipeName!)
            }
        }
    }
    
    
    //var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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
