//
//  CustomVisualEffectView.swift
//  FeedrApp
//
//  Created by Yvette Ruiz on 11/8/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit

class CustomVisualEffectView: UIVisualEffectView {


        
        //  Border
        
        @IBInspectable public var borderColor: UIColor = UIColor.clear {
            didSet {
                layer.borderColor = borderColor.cgColor
            }
        }
        
        @IBInspectable public var borderWidth: CGFloat = 0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
        
        @IBInspectable public var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                if cornerRadius > 0 {
                    clipsToBounds = true
                } else {
                    clipsToBounds = false
                }
            }
        }
    
    @IBInspectable public var shadowOpacity: CGFloat = 0
    @IBInspectable public var shadowColor: UIColor = UIColor.clear
    @IBInspectable public var shadowRadius: CGFloat = 0
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 0)
}
