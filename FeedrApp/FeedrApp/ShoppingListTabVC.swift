//
//  ShoppingListTabVC.swift
//  FeedrApp
//
//  Created by Navneet Pandey on 12/5/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class ShoppingListTabVC: UITableViewController {

    var favRecipes: [Recipe] = []
    private var selectedRecipe = Recipe()
    var recipeIngredients = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        PopulateTable()
    }
    
    func PopulateTable()
    {
        DispatchQueue.main.async
            {
                self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FavoritesVC.favRecipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        //  Initialize the variables to tags
        let img_recipeThumbnail = cell.viewWithTag(1) as! UIImageView
        let lbl_recipeName = cell.viewWithTag(2) as! UILabel
        
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
        lbl_recipeName.text = FavoritesVC.favRecipes[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        selectedRecipe = FavoritesVC.favRecipes[indexPath.row]
        self.performSegue(withIdentifier: "shoppinglist", sender: self)
        print("Tapped on row ", indexPath.row)
    }
    
    func fetchIngredientsFromRecipe()
    {
        for ingredientLine in self.selectedRecipe.ingredientLines!
        {
            self.recipeIngredients.append(ingredientLine)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shoppinglist"
        {
            let shoplist = segue.destination as! ShoppingListSwitchVC
            print("Fetching Ingredients")
            fetchIngredientsFromRecipe()
            shoplist.ingredients = self.recipeIngredients
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
     Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
