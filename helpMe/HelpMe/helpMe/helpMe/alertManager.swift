//
//  alertManager.swift
//  helpMe
//
//  Created by Александр on 03.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import Foundation
import UIKit

class showAlert {
    func show(_ textTitle: String, text: String, view: UIViewController) {
        let action = UIAlertController(title: "\(textTitle)", message: "\(text)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "ОК", style: .default, handler: nil)
        action.addAction(actionOk)
        view.present(action, animated: true, completion: nil)
    }
    
    func actionSheet(view: UIViewController){
        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: .actionSheet)
        
        let firstButton = UIAlertAction(title: "First", style: .default) { (action) in
            print("firstButton")
        }
        let secondButton =  UIAlertAction(title: "Second", style: .default) { (action) in
            print("secondButton")
        }
        
        alertController.addAction(firstButton)
        alertController.addAction(secondButton)
        view.present(alertController, animated: true, completion: nil)
    }
    
   
}
