//
//  ViewController.swift
//  helpMe
//
//  Created by Александр on 24.01.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
import InputMask

class ViewController: UIViewController {

    var click : Bool?
    let permissins: [SPRequestPermissionType] = [.camera, .photoLibrary, .notification, .locationAlways]

    
    @IBOutlet var listener: PolyMaskTextFieldDelegate!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var phoneText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        click = true
        listener.affineFormats = [
            "+7 ([000]) [000] [00] [00]"
        ]
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
    
    func login(){
        if (phoneText.text == "+7 (989) 819 79 57" && passwordTextField.text == "hatcndh42"){
            self.performSegue(withIdentifier: "loginsTest", sender: nil)
        } else {
            showAlert().show("Логин или пароль неверный", text: "Ошибка", view: self)
        }
    }
    
    
    @IBAction func passwordButtonClick(_ sender: Any) {
        if (click==true){
            passwordTextField.isSecureTextEntry = false
            click = false
            passwordButton.setImage(UIImage(named: "showPassword"), for: UIControlState.normal)
        } else{
            passwordTextField.isSecureTextEntry = true
            click = true
            passwordButton.setImage(UIImage(named: "hidePassword"), for: UIControlState.normal)
        }
    }
    
    
    
    func firstStart(){
        let launchBefore = UserDefaults.standard.bool(forKey: "launchBefore")
        if launchBefore {
            print("не первый раз")
        } else{
            print("первый раз")
            UserDefaults.standard.set(true, forKey: "launchBefore")
            SPRequestPermission.dialog.interactive.present(on: self, with: self.permissins)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        firstStart()
    }
    


    func setupPassword(){
        
    }

}

