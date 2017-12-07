//
//  CustomTableView.swift
//  FeedrApp
//
//  Created by Jonathan Shakib on 12/7/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTableView: UITableView {
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            if let image = backgroundImage {
                let backgroundImage = UIImageView(image: image)
                backgroundImage.contentMode = UIViewContentMode.center
                backgroundImage.clipsToBounds = false
                self.backgroundView = backgroundImage
            }
        }
    }
    
}
