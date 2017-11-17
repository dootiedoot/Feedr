//
//  FirstViewController.swift
//  FeedrApp
//
//  Created by James Perry on 10/9/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    @IBOutlet var lbl_usernamepf: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lbl_usernamepf.text = "Hello " + JamesVariables.Globalusername
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

