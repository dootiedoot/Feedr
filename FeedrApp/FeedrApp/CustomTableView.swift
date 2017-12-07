//
//  CustomTableView.swift
//  FeedrApp
//
//  Created by Yvette Ruiz on 12/6/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    
        
        @IBInspectable var backgroundImage: UIImage? {
            didSet {
                if let image = backgroundImage {
                    let backgroundImage = UIImageView(image: image)
                    backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
                    backgroundImage.clipsToBounds = false
                    self.backgroundView = backgroundImage
                }
            }
        }
        
    }


