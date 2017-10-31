//
//  ViewController.swift
//  FeedrApp
//
//  Created by Navneet Pandey on 10/30/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class ToTabBarController: UITabBarController
{
    var name : String = ""
    var user_id = -1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("Name is \(name)")
        print("UserID is \(user_id)")
        performSegue(withIdentifier: "tosearch", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "tosearch")
        {
            let segueVar = segue.destination as! RecipeSearchVC
            segueVar.user_id = self.user_id
        }
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
