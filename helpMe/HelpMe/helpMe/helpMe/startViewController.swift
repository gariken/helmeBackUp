//
//  startViewController.swift
//  helpMe
//
//  Created by Александр on 25.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class startViewController: UIViewController {

    @IBAction func startAction(_ sender: Any) {
        StoryBoardGo().go(identifer: "login", view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

   

}
