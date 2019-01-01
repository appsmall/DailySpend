//
//  Extension.swift
//  DailySpend
//
//  Created by Shashank Panwar on 08/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

extension UIView {
    
    // Corner View
    func cornerView() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
    
    // Shadow on View
    func shadow(isCorner: Bool, color: UIColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: -0.1, height: -0.1)
        
        if isCorner {
            // Cornered Shape View
            self.layer.shadowPath = CGPath(roundedRect: self.bounds, cornerWidth: self.frame.width, cornerHeight: self.frame.height / 2, transform: nil)
        }
        else {
            // Square Shape View
            
        }
    }
    
}

// MARK:- UIBUTTON
extension UIButton {
    func textShadow() {
        self.titleLabel?.layer.shouldRasterize = true
        self.titleLabel?.layer.shadowRadius = 1.0
        self.titleLabel?.layer.shadowOpacity = 0.7
        self.titleLabel?.shadowOffset = CGSize(width: 0, height: 0)
        self.setTitleShadowColor(UIColor.lightGray, for: .normal)
        
    }
}

// MARK:- UICOLOR
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}
