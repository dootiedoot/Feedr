//
//  TabBarController.swift
//  FeedrApp
//
//  Created by Navneet Pandey on 12/4/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var name: String = ""
    var user_id = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(name + String(user_id))
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
