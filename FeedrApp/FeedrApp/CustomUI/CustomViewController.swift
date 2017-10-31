//
//  CustomViewController.swift
//  FeedrApp
//
//  Created by Yvette Ruiz on 10/31/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit
@IBDesignable
class CustomViewController: UIViewController {
    
    @IBInspectable var lightStatusBar: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            if lightStatusBar {
                return UIStatusBarStyle.lightContent
            } else {
                return UIStatusBarStyle.default
            }
        }
    }
}
