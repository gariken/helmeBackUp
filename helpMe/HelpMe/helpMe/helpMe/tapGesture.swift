//
//  tapGesture.swift
//  helpMe
//
//  Created by Александр on 09.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import Foundation
import UIKit

class TapGesture {
    func clickTerms(_ textView: UITextView, aSelector: Selector){
        let gesture = UITapGestureRecognizer(target: self, action: aSelector)
        textView.isUserInteractionEnabled = true
        textView.addGestureRecognizer(gesture)
        print("успех")
    }
    
    
    
}
