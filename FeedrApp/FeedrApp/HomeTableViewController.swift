//
//  HomeTableViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/21/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
