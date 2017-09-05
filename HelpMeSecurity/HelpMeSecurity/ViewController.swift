//
//  ViewController.swift
//  HelpMeSecurity
//
//  Created by Александр on 28.03.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
import AKMaskField

class ViewController: UIViewController {

    @IBOutlet weak var number: AKMaskField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func open(_ sender: Any) {
        review()
    }
    //MARK: Тестовый доступ для ItunesConnect и Тестировщиков

    func review(){
        if (number.text! == "16 - 45 - 96" && passwordTextFiled.text! == "345674"){
            self.performSegue(withIdentifier: "send", sender: nil)
        } else {
            AlertStandart().show("Ошибка", text: "Логин или пароль введены неверно", view: self)
        }
    }


}

