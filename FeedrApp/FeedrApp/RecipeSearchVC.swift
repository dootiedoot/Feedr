//
//  HomeTableViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/21/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

extension Array {
	mutating func shuffle() {
		for i in 0 ..< (count - 1) {
			let j = Int(arc4random_uniform(UInt32(count - i))) + i
			swapAt(i, j)
		}
	}
}

class RecipeSearchVC: UITableViewController, DataSendingDelegate
{
    //  BUTTONS
    @IBOutlet weak var lbl_searchbar: UITextField!
    
    private var result = Result()
	static var recommendations = [Recipe]()
	private var selectedRecipeID : String = ""

    var allergyNames = [String]()
    static var userAllergyEnums = [Allergy]()

    private var currentSelectedTab = 0

	var name = ""
	var user_id = -1
    
    static var excludeCuisines = [Cuisine]()
    static var excludeCourses = [Course]()
    static var excludeHolidays = [Holiday]()
	
    func userDidSendData(cuisine: [Cuisine], course: [Course], holiday: [Holiday])
    {
        print("Data Received")
		RecipeSearchVC.excludeCuisines = cuisine
		RecipeSearchVC.excludeCourses = course
		RecipeSearchVC.excludeHolidays = holiday
    }
    
    @IBAction func selectFilter(_ sender: UIBarButtonItem)
    {
        print("Go For it")
        performSegue(withIdentifier: "RecipeFilter", sender: self)
    }
    
    @IBAction func btn_Search(_ sender: Any)
    {
        //  if the lbl_searchbar isnt empty...
		if lbl_searchbar.text != nil && lbl_searchbar.text != ""
        {
            //  if the lbl_searchbar isnt empty...
            YummlyAPI.GetSearch(
                search: lbl_searchbar.text!,
                requirePictures: true,
                allowedIngredients: [],
				excludedIngredients: [],
                allowedAllergies: RecipeSearchVC.userAllergyEnums,
                allowedDiet: [],
                allowedCuisines: [],
				excludedCuisines: RecipeSearchVC.excludeCuisines,
                allowedCourses: [],
                excludeCourses: RecipeSearchVC.excludeCourses,
                allowedHoliday: [],
                excludeHoliday: RecipeSearchVC.excludeHolidays,
                maxTotalTimeInSeconds: -1,
                maxResults: 50)
            { result in
				//	Error handling. (Use a pop-up)
				if result.totalMatchCount! <= 0
				{
					print("No results found!")
					return
				}
				
                //  Update the current result variable so it can be used outside of this function
                self.result = result
                
                //  Dispatch queue so table view is refreshed with data
                DispatchQueue.main.async
                {
                    self.tableView.reloadData()
                }
            }
        }
		else
		{
			print("No search parameter! Doing nothing.")
		}
    }
    

    override func viewDidAppear(_ animated: Bool)
    {
        print("Finding userAllergyEnums Next")
        findUserAllergies(uid: user_id)
    }
        
    //  Controls the logic for segmented tabs under search bar
    @IBAction func OnTabSelected(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            //print("Browsing...")
            currentSelectedTab = 0
            break
        case 1:
            //print("Recomendations...")
            currentSelectedTab = 1
			
			//	Shuffle recommendations
			if RecipeSearchVC.recommendations.count > 0
			{
				RecipeSearchVC.recommendations.shuffle()
			}
			
			//print("Refreshing table for recommendations...")
			print("showing \(RecipeSearchVC.recommendations.count) recommendations.")
			for recipe in RecipeSearchVC.recommendations
			{
				print("Recommended: \(recipe.name)")
			}
            break
        default:
            //print("Unknown tab selected...")
            break
        }
		
        //  Dispatch queue so table view is refreshed with data
        DispatchQueue.main.async
        {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.hideKeyboard()
		print("Id is \(user_id) Name is \(name)")
		
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        lbl_searchbar.autocorrectionType = .no
        
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
        if currentSelectedTab == 0
        {
            return self.result.matches!.count
        }
        else
        {
            return RecipeSearchVC.recommendations.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //  Initialize the variables to tags
        let img_recipeThumbnail = cell.viewWithTag(1) as! UIImageView
        let lbl_recipeName = cell.viewWithTag(2) as! UILabel
        let lbl_cookingTime = cell.viewWithTag(3) as! UILabel
        
        //  Assign variables to actual values
        //  if current tab is browsing...
        if currentSelectedTab == 0
        {
            //  Image thumbnail (code is long because there needs to be a handler for when img download fails for whatever reason.)
            if result.matches![indexPath.row].smallImageUrls != nil
            {
                let url = URL(string: result.matches![indexPath.row].smallImageUrls![0])
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
            lbl_recipeName.text = result.matches![indexPath.row].recipeName
            //  Cooking Time
            lbl_cookingTime.text = result.matches![indexPath.row].GetCookingTime()
        }
        //  if current tab is recommended....
        else
        {
            //  Image thumbnail (code is long because there needs to be a handler for when img download fails for whatever reason.)
            if RecipeSearchVC.recommendations[indexPath.row].images![0] != nil
            {
                let url = URL(string: RecipeSearchVC.recommendations[indexPath.row].images![0].hostedLargeUrl!)
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
            lbl_recipeName.text = RecipeSearchVC.recommendations[indexPath.row].name
            //  Cooking Time
            lbl_cookingTime.text = RecipeSearchVC.recommendations[indexPath.row].GetCookingTime()
        }
        
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
		self.selectedRecipeID = result.matches![indexPath.row].id!
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
			//print("Prepping segue...")
			
            //  Cache the recipe detail controller and pass the data over
            let RecipeDetailController = segue.destination as! RecipeDetailVC
            RecipeDetailController.recipeID = selectedRecipeID
			RecipeDetailController.this_user_id = user_id
        }
        else
        if segue.identifier == "RecipeFilter"
        {
            let RecipeFilterController = segue.destination as! PreferencesTableViewController
            
            if let backToSearch = segue.destination as? PreferencesTableViewController {
                backToSearch.delegate = self
            }
        }
        else
        {
            print("Could not find segue identifier")
        }
    }
    
    func findInAllergy(allergy_id: Int)
    {
        let fileManager =  FileManager.default
        var db : OpaquePointer? = nil
        var dbURl : NSURL? = nil
        //var aid: String = "-1"
        
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
                var selectStatement : OpaquePointer? = nil
                let selectQuery = "SELECT * FROM allergies WHERE id = '\(allergy_id)';"
                
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        let queryResultCol1 = sqlite3_column_text(selectStatement, 1)
                        let aname = String(cString: queryResultCol1!)
                        print(aname)
                        self.allergyNames.append(aname)
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }
    }
    
    func findUserAllergies(uid:Int)
    {
        let fileManager =  FileManager.default
        var db : OpaquePointer? = nil
        var dbURl : NSURL? = nil
        var aid: String = "-1"
        var allergyIDs = [Int]()
        
        self.allergyNames.removeAll()
        RecipeSearchVC.userAllergyEnums.removeAll()
        
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
                var selectStatement : OpaquePointer? = nil
                let selectQuery = "SELECT * FROM userallergies WHERE user_id = '\(uid)';"
                
                if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK
                {
                    while sqlite3_step(selectStatement) == SQLITE_ROW
                    {
                        let queryResultCol = sqlite3_column_text(selectStatement, 2)
                        aid = String(cString: queryResultCol!)
                        
                        allergyIDs.append(Int(aid)!)
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }
        
        for allergyID in allergyIDs
        {
            findInAllergy(allergy_id: allergyID)
        }
        
        for allergyName in allergyNames
        {
            convertToEnum(allergyName: allergyName)
        }
    }
    
    func convertToEnum(allergyName: String)
    {
        let allergyFound = allergyNames.contains(where: {
            $0.range(of: allergyName, options: .caseInsensitive) != nil
        })
        
        if allergyFound == true && allergyName == "Gluten"
        {
            RecipeSearchVC.userAllergyEnums.append(Allergy.Gluten)
        }
        else
        if allergyFound == true && allergyName == "Egg"
        {
            RecipeSearchVC.userAllergyEnums.append(Allergy.Egg)
        }
        else
        if allergyFound == true && allergyName == "Sesame"
        {
            RecipeSearchVC.userAllergyEnums.append(Allergy.Sesame)
        }
        else
        if allergyFound == true && allergyName == "Seafood"
        {
            RecipeSearchVC.userAllergyEnums.append(Allergy.Seafood)
        }
        else
        if allergyFound == true && allergyName == "TreeNut"
        {
            RecipeSearchVC.userAllergyEnums.append(Allergy.TreeNut)
        }
        else
        if allergyFound == true && allergyName == "Wheat"
        {
            RecipeSearchVC.userAllergyEnums.append(Allergy.Wheat)
        }
        else
        if allergyFound == true && allergyName == "Peanut"
        {
            RecipeSearchVC.userAllergyEnums.append(Allergy.Peanut)
        }
        else
        if allergyFound == true && allergyName == "Soy"
        {
            RecipeSearchVC.userAllergyEnums.append(Allergy.Soy)
        }
        else
        if allergyFound == true && allergyName == "Sulfite"
        {
        	RecipeSearchVC.userAllergyEnums.append(Allergy.Sulfite)
        }
        else
        if allergyFound == true && allergyName == "Diary"
        {
            RecipeSearchVC.userAllergyEnums.append(Allergy.Diary)
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
