//
//  RoundUIView.swift
//  QuickFoodMenu
//
//  Created by maojie on 4/21/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit
@IBDesignable class RoundUIView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
