//
//  cardViewDesign.swift
//  helpMe
//
//  Created by Александр on 11.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

@IBDesignable
class CardViewDesignable: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
