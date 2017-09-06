//
//  slideMenu.swift
//  helpMe
//
//  Created by Александр on 01.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class slideMenu: UIViewController {

    @IBOutlet weak var labelName: UILabel!
   
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBAction func oplataButton(_ sender: Any) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "payment")
        self.present(vc, animated: true, completion: nil) 
    }
    
    @IBAction func settingButtonView(_ sender: Any) {
        handl()
    }
    
    @IBOutlet weak var phoneNumberHelpLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        click()
        clickPhone()
        RectangleImage().rectangleImage(image: avatarImage)
    }
    
    func rectabgleImgae(avatar: UIImageView){
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
        avatarImage.clipsToBounds = true
    }
    

    
    func clickPhone(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(slideMenu.phoneActive))
        phoneNumberHelpLabel.isUserInteractionEnabled = true
        phoneNumberHelpLabel.addGestureRecognizer(gesture)
    }

    func click(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(slideMenu.handleUp))
        labelName.isUserInteractionEnabled = true
        labelName.addGestureRecognizer(gesture)
    }
    
    
    
    func phoneActive(sender: UITapGestureRecognizer){
        let phoneManeger = PhoneNumberManager()
        phoneManeger.phoneInsert(phone: "+79002403131")
        print("123")
    }
    
    func handleUp(sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LK")
        self.present(vc, animated: true, completion: nil)
    }
    
    func handl(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "settingView")
        self.present(vc, animated: true, completion: nil)
    }
   

}
