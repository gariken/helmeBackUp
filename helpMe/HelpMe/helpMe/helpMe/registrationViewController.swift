//
//  registrationViewController.swift
//  helpMe
//
//  Created by Александр on 03.03.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
import SinchVerification
import InputMask

class registrationViewController: UIViewController, MaskedTextFieldDelegateListener {

    @IBOutlet var listener: PolyMaskTextFieldDelegate!
    @IBOutlet weak var redVector: UIImageView!
    @IBOutlet weak var greenVector: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumbertextfiled: UITextField!
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var termsView: UITextView!
    @IBOutlet weak var checkBoxButton: checkBox!
    @IBOutlet weak var registerButton: UIButton!
    var verification: Verification!
    var applicationKey = "36e3873e-6ccf-498c-86c7-e99e639ee0ae"

    
 
    @IBAction func registerAction(_ sender: AnyObject) {
        correct()
    }
    
    @IBAction func dismisButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listener.affineFormats = [
            "+7 ([000]) [000] [00] [00]"
        ]
        checkBoxButton.addTarget(self, action: #selector(registrationViewController.proverka), for: .allTouchEvents)
        clickTerms()
        
    }
    
    
    func correct(){
        let mask: Mask = try! Mask(format: "+7[000][000][00][00]")
        let input: String = phoneNumbertextfiled.text!
        let result: Mask.Result = mask.apply(
            toText: CaretString(
                string: input,
                caretPosition: input.endIndex
            ),
            autocomplete: true // you may consider disabling autocompletion for your case
        )
        let output: String = result.formattedText.string
        print("Телефонный номер - \(output)")
        self.verifications(phoneNumberApp: output)
    }

    
    func proverka(){
        if checkBoxButton.isChecked == true{
            registerButton.isEnabled = true
        } else{
        registerButton.isEnabled = false
        }
    }
    
    func verifications(phoneNumberApp: String?){
        verification = SMSVerification(applicationKey, phoneNumber: phoneNumberApp!)
        
        verification.initiate { (success:InitiationResult, error:Error?) -> Void in
            if (success.success){
                 self.performSegue(withIdentifier: "verifySMS", sender: send)
                print("СМС-отправлено")
            } else {
               print("ошибка")
            }
        }

    }
    
    
    func clickTerms(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(registrationViewController.showTerms))
        termsView.isUserInteractionEnabled = true
        termsView.addGestureRecognizer(gesture)
    }
    
    func showTerms(sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "showTerms", sender: self)
    }
    
    func updateUI(){
        if (nameTextField.text?.isEmpty == false){
            redVector.image = #imageLiteral(resourceName: "redVector")
            nameIcon.image = #imageLiteral(resourceName: "redNameIcon")
        }
        if (phoneNumbertextfiled.text?.isEmpty == false){
            greenVector.image = #imageLiteral(resourceName: "greentVector")
            phoneIcon.image = #imageLiteral(resourceName: "colorTelephoneIcon")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "verifySMS") {
            let enterCodeVC = segue.destination as! enterViewController
            enterCodeVC.verifiction = self.verification
        }
    }

}
