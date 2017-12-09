//
//  PreferencesTableViewController.swift
//  FeedrApp
//
//  Created by James Perry on 11/1/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

protocol DataSendingDelegate
{
    func userDidSendData(cuisine: [Cuisine], course: [Course], holiday: [Holiday])
}

class PreferencesTableViewController: UITableViewController
{
    var delegate: DataSendingDelegate?
    static var excludeCuisineList = [Cuisine]()
    static var excludeCourseList = [Course]()
    static var excludeHolidayList = [Holiday]()
    
    static var listCuisine = [String]()
    static var listCourse = [String]()
    static var listHoliday = [String]()

    var sections = ["Cuisines", "Courses", "Holidays"]
    var items = [["American", "Asian", "Barbecue", "Cajun", "Chinese", "Cuban", "English", "French", "German", "Greek", "Hawaiin", "Hungarian", "Indian", "Irish", "Italian", "Japanese", "Mediterranean", "Mexican", "Moroccan", "Portugese", "Southern", "Southwestern", "Spanish", "Swedish", "Thai"], ["Appetizers", "Beverages", "Breads", "Breakfast", "Cocktails", "Desserts", "Lunch", "Main", "Salads", "Sides", "Soups"], ["Christmas", "FourthOfJuly", "Halloween", "Hanukkah", "NewYear", "Summer", "SuperBowl", "Thanksgiving"]]
    var sectionNo = 0
    var rowNo = 0
    var labelName = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("In Filters")
    
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        if delegate != nil
        {
            print("CheckData")
            delegate?.userDidSendData(cuisine: PreferencesTableViewController.excludeCuisineList, course: PreferencesTableViewController.excludeCourseList, holiday: PreferencesTableViewController.excludeHolidayList)
            print("DataSent")
        }
        else
        {
            print("can't Find a Delegate")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func AddCuisineToList(cuisineName: String)
    {
        if cuisineName == "American"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.American)
            PreferencesTableViewController.listCuisine.append("American")
        }
        else
        if cuisineName == "Asian"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Asian)
            PreferencesTableViewController.listCuisine.append("Asian")
        }
        else
        if cuisineName == "Barbecue"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Barbecue)
            PreferencesTableViewController.listCuisine.append("Barbecue")
        }
        else
        if cuisineName == "Cajun"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Cajun)
            PreferencesTableViewController.listCuisine.append("Cajun")
        }
        else
        if cuisineName == "Chinese"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Chinese)
            PreferencesTableViewController.listCuisine.append("Chinese")
        }
        else
        if cuisineName == "Cuban"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Cuban)
            PreferencesTableViewController.listCuisine.append("Cuban")
        }
        else
        if cuisineName == "English"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.English)
            PreferencesTableViewController.listCuisine.append("English")
        }
        else
        if cuisineName == "French"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.French)
            PreferencesTableViewController.listCuisine.append("French")
        }
        else
        if cuisineName == "German"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.German)
            PreferencesTableViewController.listCuisine.append("German")
        }
        else
        if cuisineName == "Greek"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Greek)
            PreferencesTableViewController.listCuisine.append("Greek")
        }
        else
        if cuisineName == "Hawaiin"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Hawaiin)
            PreferencesTableViewController.listCuisine.append("Hawaiin")
        }
        else
        if cuisineName == "Hungarian"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Hungarian)
            PreferencesTableViewController.listCuisine.append("Hungarian")
        }
        else
        if cuisineName == "Indian"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Indian)
            PreferencesTableViewController.listCuisine.append("Indian")
        }
        else
        if cuisineName == "Irish"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Irish)
            PreferencesTableViewController.listCuisine.append("Irish")
        }
        else
        if cuisineName == "Italian"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Italian)
            PreferencesTableViewController.listCuisine.append("Italian")
        }
        else
        if cuisineName == "Japanese"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Japanese)
            PreferencesTableViewController.listCuisine.append("Japanese")
        }
        else
        if cuisineName == "Mediterranean"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Mediterranean)
            PreferencesTableViewController.listCuisine.append("Mediterranean")
        }
        else
        if cuisineName == "Mexican"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Mexican)
            PreferencesTableViewController.listCuisine.append("Mexican")
        }
        else
        if cuisineName == "Moroccan"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Moroccan)
            PreferencesTableViewController.listCuisine.append("Moroccan")
        }
        else
        if cuisineName == "Portugese"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Portugese)
            PreferencesTableViewController.listCuisine.append("Portugese")
        }
        else
        if cuisineName == "Southern"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Southern)
            PreferencesTableViewController.listCuisine.append("Southern")
        }
        else
        if cuisineName == "Southwestern"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Southwestern)
            PreferencesTableViewController.listCuisine.append("Southwestern")
        }
        else
        if cuisineName == "Spanish"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Spanish)
            PreferencesTableViewController.listCuisine.append("Spanish")
        }
        else
        if cuisineName == "Swedish"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Swedish)
            PreferencesTableViewController.listCuisine.append("Swedish")
        }
        else
        if cuisineName == "Thai"
        {
            PreferencesTableViewController.excludeCuisineList.append(Cuisine.Thai)
            PreferencesTableViewController.listCuisine.append("Thai")
        }
    }
    
    func AddCourseToList(courseName: String)
    {
        if courseName == "Appetizers"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Appetizers)
            PreferencesTableViewController.listCourse.append("Appetizers")
        }
        else
        if courseName == "Beverages"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Beverages)
            PreferencesTableViewController.listCourse.append("Beverages")
        }
        else
        if courseName == "Breads"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Breads)
            PreferencesTableViewController.listCourse.append("Breads")
        }
        else
        if courseName == "Breakfast"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Breakfast)
            PreferencesTableViewController.listCourse.append("Breakfast")
        }
        else
        if courseName == "Cocktails"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Cocktails)
            PreferencesTableViewController.listCourse.append("Cocktails")
        }
        else
        if courseName == "Desserts"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Desserts)
            PreferencesTableViewController.listCourse.append("Desserts")
        }
        else
        if courseName == "Lunch"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Lunch)
            PreferencesTableViewController.listCourse.append("Lunch")
        }
        else
        if courseName == "Main"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Main)
            PreferencesTableViewController.listCourse.append("Main")
        }
        else
        if courseName == "Salads"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Salads)
            PreferencesTableViewController.listCourse.append("Salads")
        }
        else
        if courseName == "Sides"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Sides)
            PreferencesTableViewController.listCourse.append("Sides")
        }
        else
        if courseName == "Soups"
        {
            PreferencesTableViewController.excludeCourseList.append(Course.Soups)
            PreferencesTableViewController.listCourse.append("Soups")
        }
    }
    
    func AddHolidayToList(holidayName: String)
    {
        if holidayName == "Christmas"
        {
            PreferencesTableViewController.excludeHolidayList.append(Holiday.Christmas)
            PreferencesTableViewController.listHoliday.append("Christmas")
        }
        else
        if holidayName == "FourthOfJuly"
        {
            PreferencesTableViewController.excludeHolidayList.append(Holiday.FourthOfJuly)
            PreferencesTableViewController.listHoliday.append("FourthOfJuly")

        }
        else
        if holidayName == "Halloween"
        {
            PreferencesTableViewController.excludeHolidayList.append(Holiday.Halloween)
            PreferencesTableViewController.listHoliday.append("Halloween")

        }
        else
        if holidayName == "Hanukkah"
        {
            PreferencesTableViewController.excludeHolidayList.append(Holiday.Hanukkah)
            PreferencesTableViewController.listHoliday.append("Hanukkah")

        }
        else
        if holidayName == "NewYear"
        {
            PreferencesTableViewController.excludeHolidayList.append(Holiday.NewYear)
            PreferencesTableViewController.listHoliday.append("NewYear")
        }
        else
        if holidayName == "Summer"
        {
            PreferencesTableViewController.excludeHolidayList.append(Holiday.Summer)
            PreferencesTableViewController.listHoliday.append("Summer")

        }
        else
        if holidayName == "SuperBowl"
        {
            PreferencesTableViewController.excludeHolidayList.append(Holiday.SuperBowl)
            PreferencesTableViewController.listHoliday.append("SuperBowl")
        }
        else
        if holidayName == "Thanksgiving"
        {
            PreferencesTableViewController.excludeHolidayList.append(Holiday.Thanksgiving)
            PreferencesTableViewController.listHoliday.append("Thanksgiving")
        }
    }
    
    @objc func switchValueDidChange(sender:UISwitch!)
    {
        if !sender.isOn
        {
            print("Change")
            var tagName = sender.restorationIdentifier!

            var sec = 0
            var row = 0
            var row1 = ""
            var row2 = ""
            
            if tagName.characters.count == 2
            {
                
                sec = Int(String(tagName[tagName.startIndex]))!
                row = Int(String(tagName[tagName.index(tagName.startIndex, offsetBy:1)]))!
            }
            else
            if tagName.characters.count == 3
            {
              
                sec = Int(String(tagName[tagName.startIndex]))!
                row1 = String(tagName[tagName.index(tagName.startIndex, offsetBy:1)])
                row2 = String(tagName[tagName.index(tagName.startIndex, offsetBy:2)])
                row = Int(row1 + row2)!
            }
			
			//	COMMENTED OUT BY CHAD. It was spamming console when scrolling.
            /*print(sender.tag)
            print(sec)
            print(row)
            print(self.items[sec][row])*/
            
            if sec == 0
            {
                 AddCuisineToList(cuisineName: self.items[sec][row])
                    print(PreferencesTableViewController.listCuisine)
            }
            else
            if sec == 1
            {
                AddCourseToList(courseName: self.items[sec][row])
				print(PreferencesTableViewController.listCourse)
            }
            else
            {
                AddHolidayToList(holidayName: self.items[sec][row])
				print(PreferencesTableViewController.listHoliday)
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        	return self.sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let lbl_filtername = cell.viewWithTag(1) as! UILabel
        let switch_choice = cell.viewWithTag(2) as! UISwitch
        var tagName = String(indexPath.section) + String(indexPath.row)
        
        var itemName = self.items[indexPath.section][indexPath.row]
        lbl_filtername.text = itemName
        switch_choice.restorationIdentifier = tagName
        switch_choice.addTarget(self, action: #selector(self.switchValueDidChange), for: .valueChanged)
        
        //print(tagName + lbl_filtername.text!)
        let cuisineFound = PreferencesTableViewController.listCuisine.contains(where: {
            $0.range(of: itemName, options: .caseInsensitive) != nil
        })
        let courseFound = PreferencesTableViewController.listCourse.contains(where: {
            $0.range(of: itemName, options: .caseInsensitive) != nil
        })
        let holidayFound = PreferencesTableViewController.listHoliday.contains(where: {
            $0.range(of: itemName, options: .caseInsensitive) != nil
        })
      
        if (cuisineFound == true || courseFound == true || holidayFound == true)
        {
            switch_choice.setOn(false, animated: true)
        }
        else
        {
            switch_choice.setOn(true, animated: true)
        }
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
