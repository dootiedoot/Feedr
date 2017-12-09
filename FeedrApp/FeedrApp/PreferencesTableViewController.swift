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
    
    
    func StringToEnumCuisine(cuisineName: String) -> Cuisine
    {
        if cuisineName == "American"
        {
            return Cuisine.American
        }
        else
        if cuisineName == "Asian"
        {
          return Cuisine.Asian
        }
        else
        if cuisineName == "Barbecue"
        {
          return Cuisine.Barbecue
        }
        else
        if cuisineName == "Cajun"
        {
            return Cuisine.Cajun
        }
        else
        if cuisineName == "Chinese"
        {
            return Cuisine.Chinese
        }
        else
        if cuisineName == "Cuban"
        {
            return Cuisine.Cuban
        }
        else
        if cuisineName == "English"
        {
            return Cuisine.English
        }
        else
        if cuisineName == "French"
        {
            return Cuisine.French
        }
        else
        if cuisineName == "German"
        {
            return Cuisine.German
        }
        else
        if cuisineName == "Greek"
        {
            return Cuisine.Greek
        }
        else
        if cuisineName == "Hawaiin"
        {
            return Cuisine.Hawaiin
        }
        else
        if cuisineName == "Hungarian"
        {
            return Cuisine.Hungarian
        }
        else
        if cuisineName == "Indian"
        {
            return Cuisine.Indian
        }
        else
        if cuisineName == "Irish"
        {
            return Cuisine.Irish
        }
        else
        if cuisineName == "Italian"
        {
            return Cuisine.Italian
        }
        else
        if cuisineName == "Japanese"
        {
            return Cuisine.Japanese
        }
        else
        if cuisineName == "Mediterranean"
        {
            return Cuisine.Mediterranean
        }
        else
        if cuisineName == "Mexican"
        {
            return Cuisine.Mexican
        }
        else
        if cuisineName == "Moroccan"
        {
            return Cuisine.Moroccan
        }
        else
        if cuisineName == "Portugese"
        {
            return Cuisine.Portugese
        }
        else
        if cuisineName == "Southern"
        {
            return Cuisine.Southern
        }
        else
        if cuisineName == "Southwestern"
        {
             return Cuisine.Southwestern
        }
        else
        if cuisineName == "Spanish"
        {
            return Cuisine.Spanish
        }
        else
        if cuisineName == "Swedish"
        {
              return Cuisine.Swedish
        }
        else
        if cuisineName == "Thai"
        {
              return Cuisine.Thai
        }
        
        return Cuisine.Thai
    }
    
    func StringToEnumCourse(courseName: String) -> Course
    {
        if courseName == "Appetizers"
        {
            return Course.Appetizers
        }
        else
        if courseName == "Beverages"
        {
            return Course.Beverages
        }
        else
        if courseName == "Breads"
        {
            return Course.Breads
        }
        else
        if courseName == "Breakfast"
        {
            return Course.Breakfast
        }
        else
        if courseName == "Cocktails"
        {
            return Course.Cocktails
        }
        else
        if courseName == "Desserts"
        {
            return Course.Desserts
        }
        else
        if courseName == "Lunch"
        {
              return Course.Lunch
        }
        else
        if courseName == "Main"
        {
              return Course.Main
        }
        else
        if courseName == "Salads"
        {
            return Course.Salads
        }
        else
        if courseName == "Sides"
        {
            return Course.Sides
        }
        else
        if courseName == "Soups"
        {
            return Course.Soups
        }
        
        return Course.Soups
    }
    
    func StringToEnumHoliday(holidayName: String) -> Holiday
    {
        if holidayName == "Christmas"
        {
            return Holiday.Christmas
        }
        else
        if holidayName == "FourthOfJuly"
        {
            return Holiday.FourthOfJuly
        }
        else
        if holidayName == "Halloween"
        {
            return Holiday.Halloween
        }
        else
        if holidayName == "Hanukkah"
        {
             return Holiday.Hanukkah
        }
        else
        if holidayName == "NewYear"
        {
             return Holiday.NewYear
        }
        else
        if holidayName == "Summer"
        {
            return Holiday.Summer
        }
        else
        if holidayName == "SuperBowl"
        {
            return Holiday.SuperBowl
        }
        else
        if holidayName == "Thanksgiving"
        {
            return Holiday.Thanksgiving
        }
        
        return Holiday.Thanksgiving
    }
    
    func RemoveCuisineFromList(item: String)
    {
        let itemEnum = StringToEnumCuisine(cuisineName: item)
        if let index = PreferencesTableViewController.excludeCuisineList.index(of: itemEnum) {
            PreferencesTableViewController.excludeCuisineList.remove(at: index)
        }
        
        if let index = PreferencesTableViewController.listCuisine.index(of: item) {
            PreferencesTableViewController.listCuisine.remove(at: index)
        }
    }
    
    func RemoveCourseFromList(item: String)
    {
        let itemEnum = StringToEnumCourse(courseName: item)
        if let index = PreferencesTableViewController.excludeCourseList.index(of: itemEnum) {
            PreferencesTableViewController.excludeCourseList.remove(at: index)
        }
        
        if let index = PreferencesTableViewController.listCourse.index(of: item) {
            PreferencesTableViewController.listCourse.remove(at: index)
        }
    }
    
    func RemoveHolidayFromList(item: String)
    {
        let itemEnum = StringToEnumHoliday(holidayName: item)
        if let index = PreferencesTableViewController.excludeHolidayList.index(of: itemEnum) {
            PreferencesTableViewController.excludeHolidayList.remove(at: index)
        }
        
        if let index = PreferencesTableViewController.listHoliday.index(of: item) {
            PreferencesTableViewController.listHoliday.remove(at: index)
        }
    }
    
    func AddCuisineToList(item: String)
    {
        let itemEnum = StringToEnumCuisine(cuisineName: item)
        PreferencesTableViewController.excludeCuisineList.append(itemEnum)
        PreferencesTableViewController.listCuisine.append(item)
    }
    
    func AddCourseToList(item: String)
    {
        let itemEnum = StringToEnumCourse(courseName: item)
        PreferencesTableViewController.excludeCourseList.append(itemEnum)
        PreferencesTableViewController.listCourse.append(item)
    }
    
    func AddHolidayToList(item: String)
    {
        let itemEnum = StringToEnumHoliday(holidayName: item)
        PreferencesTableViewController.excludeHolidayList.append(itemEnum)
        PreferencesTableViewController.listHoliday.append(item)
    }
    
    @objc func switchValueDidChange(sender:UISwitch!)
    {
        let tagName = sender.restorationIdentifier!
        
        var sec = 0
        var row = 0
        var row1 = ""
        var row2 = ""
        
        if tagName.count == 2
        {
            sec = Int(String(tagName[tagName.startIndex]))!
            row = Int(String(tagName[tagName.index(tagName.startIndex, offsetBy:1)]))!
        }
        else
        if tagName.count == 3
        {
            
            sec = Int(String(tagName[tagName.startIndex]))!
            row1 = String(tagName[tagName.index(tagName.startIndex, offsetBy:1)])
            row2 = String(tagName[tagName.index(tagName.startIndex, offsetBy:2)])
            row = Int(row1 + row2)!
        }
        
        let itemName = self.items[sec][row]
        
        if !sender.isOn
        {
            if sec == 0
            {
                AddCuisineToList(item: itemName)
            }
            else
            if sec == 1
            {
                AddCourseToList(item: itemName)
            }
            else
            {
                AddHolidayToList(item: itemName)
            }
        }
        else
        {
            if sec == 0
            {
                RemoveCuisineFromList(item: itemName)
            }
            else
            if sec == 1
            {
                RemoveCourseFromList(item: itemName)
            }
            else
            {
                RemoveHolidayFromList(item: itemName)
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
        let tagName = String(indexPath.section) + String(indexPath.row)
        
        let itemName = self.items[indexPath.section][indexPath.row]
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
