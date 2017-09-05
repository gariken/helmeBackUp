//
//  slideMenuViewController.swift
//  HelpMeSecurity
//
//  Created by Александр on 28.04.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class slideMenuViewController: UIViewController {
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBAction func dismis(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        avatarView.layer.cornerRadius = avatarView.frame.size.width / 2
        avatarView.clipsToBounds = true
    }
    
    @IBAction func phoneButton(_ sender: Any) {
        phoneNumber(phone: "+79002403131")
    }
    
    func phoneNumber(phone: String){
        if let url = NSURL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }

}
