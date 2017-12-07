//
//  CustomLabel.swift
//  FeedrApp
//
//  Created by Yvette Ruiz on 12/6/17.
//  Copyright © 2017 Team9. All rights reserved.
//

import UIKit
@IBDesignable
class CustomLabel: UILabel { @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
        self.layer.cornerRadius = cornerRadius
    }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var rotationAngle: CGFloat = 0 {
        didSet {
            self.transform = CGAffineTransform(rotationAngle: rotationAngle * .pi / 180)
        }
    }

@IBInspectable
 public var shadowRadius: CGFloat {
    get {
        return layer.shadowRadius
    }
    set {
        layer.shadowRadius = newValue
    }
}

@IBInspectable public
var shadowOpacity: Float {
    get {
        return layer.shadowOpacity
    }
    set {
        layer.shadowOpacity = newValue
    }
}
    @IBInspectable
    var overrideshadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }


}






