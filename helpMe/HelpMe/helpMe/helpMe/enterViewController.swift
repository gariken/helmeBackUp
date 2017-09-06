//
//  enterViewController.swift
//  helpMe
//
//  Created by Александр on 22.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
import SinchVerification

class enterViewController: UIViewController {

    @IBOutlet weak var enterCodeTextFiled: UITextField!
    @IBOutlet weak var okButton: UIButton!
    var verifiction : Verification!
    
    @IBAction func enterCodeButton(_ sender: Any) {
        verify()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterCodeTextFiled.becomeFirstResponder()
    }
    
    func verify(){
        okButton.isEnabled = false
        enterCodeTextFiled.isEnabled = false
        
        verifiction.verify(enterCodeTextFiled.text!, completion: { (success:Bool, error:Error?) -> Void in
            self.okButton.isEnabled = true
            self.enterCodeTextFiled.isEnabled = true
            if (success) {
                StoryBoardGo().go(identifer: "mainView", view: self)
            } else {
                print("no ok")
            }
        });
    }
}
    
    

