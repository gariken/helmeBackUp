//
//  RectangleImage.swift
//  helpMe
//
//  Created by Александр on 13.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class RectangleImage {
    func rectangleImage(image: UIImageView){
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
    }
}
