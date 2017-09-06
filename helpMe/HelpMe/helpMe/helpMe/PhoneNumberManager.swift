//
//  PhoneNumberManager.swift
//  helpMe
//
//  Created by Александр on 01.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import Foundation
import UIKit

class PhoneNumberManager {
    func phoneInsert(phone: String){
        if let url = NSURL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
}

