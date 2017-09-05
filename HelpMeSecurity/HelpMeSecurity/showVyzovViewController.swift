//
//  showVyzovViewController.swift
//  HelpMeSecurity
//
//  Created by Александр on 28.04.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class showVyzovViewController: UIViewController {

    @IBAction func phoneVictim(_ sender: Any) {
        phoneNumber(phone: "+79898197957")
    }
    
    @IBAction func phoneFather(_ sender: Any) {
        phoneNumber(phone: "+79898197957")
    }
    
    @IBAction func phoneMother(_ sender: Any) {
        phoneNumber(phone: "+79898197957")
    }
    
    @IBAction func dismis(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func phoneNumber(phone: String){
        if let url = NSURL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
 
}
