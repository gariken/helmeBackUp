//
//  paymentViewController.swift
//  helpMe
//
//  Created by Александр on 03.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
class paymentViewController: UIViewController {
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardTypeImage: UIImageView!
    @IBOutlet weak var cardViewBackground: CardViewDesignable!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var CVVTextField: UITextField!
    
    var cartManager:CreditCardValidator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartManager = CreditCardValidator()
    }
    
    
  
    func textField(_ CVVTextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = CVVTextField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 3 
        return true
    }

    @IBAction func textFieldDidChanged(_ sender: UITextField) {
        if let number = sender.text {
            if number.isEmpty {
                self.cardViewBackground.backgroundColor = .white
                self.cardTypeImage.image = nil
            } else {
                validateCardNumber(number: number)
                detectCardNumberType(number: number)
            }
        }

    }
    @IBAction func dismis(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }

    @IBAction func paymentButton(_ sender: Any) {
        
    }
    
    
    //MARK: CartType
    func validateCardNumber(number: String) {
        if cartManager.validate(string: number) {
            print("card number is valid")
            self.cardViewBackground.backgroundColor = .white
        } else {
            //self.cardViewBackground.backgroundColor = .red
        }
    }

    func detectCardNumberType(number: String) {
        if let type = cartManager.type(from: number) {
            self.cardTypeImage.image = UIImage(named: type.name)
        } else {
          //self.cardViewBackground.backgroundColor = .red
        }
    }

}
