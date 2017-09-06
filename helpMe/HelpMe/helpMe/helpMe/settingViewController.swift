//
//  settingViewController.swift
//  helpMe
//
//  Created by Александр on 17.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class settingViewController: UIViewController {
    
    @IBAction func pravButton(_ sender: Any) {
        handl(iden: "prav")
    }

    @IBAction func dismis(_ sender: Any) {
     self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func offer(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "offer")
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func price(_ sender: Any) {
        handl(iden: "price")
    }
  
    @IBAction func jur(_ sender: Any) {
        handl(iden: "JUR")
    }
    
    
    func handl(iden: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: iden)
        self.present(vc, animated: true, completion: nil)
    }
  

}
