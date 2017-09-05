//
//  lkViewController.swift
//  HelpMeSecurity
//
//  Created by Александр on 28.04.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class lkViewController: UIViewController {
    
    
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBAction func disabelView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rectangleImage()
    }
    
    func rectangleImage(){
        avatarView.layer.cornerRadius = avatarView.frame.size.width / 2
        avatarView.clipsToBounds = true
    }

 

}
