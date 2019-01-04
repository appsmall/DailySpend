//
//  RoundButton.swift
//  Scavenger Hunt
//
//  Created by Murthy on 21/05/18.
//  Copyright © 2018 Shashank Panwar. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var radius: CGFloat = 25 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
    
}
