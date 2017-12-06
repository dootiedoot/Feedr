//
//  CustomTableView.swift
//  FeedrApp
//
//  Created by Yvette Ruiz on 12/5/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit
@IBDesignable
class CustomTableView: UITableView {
@IBInspectable var backgroundImage: UIImage? {
        didSet {
            if let image = backgroundImage {
                let backgroundImage = UIImageView(image: image)
                backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
                backgroundImage.clipsToBounds = false
                self.backgroundView = backgroundImage
            }
        }
    }
    
}

