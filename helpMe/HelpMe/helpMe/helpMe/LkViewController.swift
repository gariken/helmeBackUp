//
//  LkViewController.swift
//  helpMe
//
//  Created by Александр on 01.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
import Foundation

class LkViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var avatarViewController: UIImageView!
    
    let picker = UIImagePickerController()
    
    @IBAction func dismisButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        click()
    }
    
    
        func actionSheet(){
            
            let alertController = UIAlertController(title: "Редактирование", message: "Изменение фотографии", preferredStyle: .actionSheet)
            
            let firstButton = UIAlertAction(title: "Загрузить из медиатеки", style: .default) { (action) in
                self.loadAvatar(typeImage: .photoLibrary)
            }
            let secondButton =  UIAlertAction(title: "Открыть фотокамеру", style: .default) { (action) in
                self.loadAvatar(typeImage: .camera)
            }
            
            let cancleButton = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
                print("cancel")
            }
            
            alertController.addAction(firstButton)
            alertController.addAction(secondButton)
            alertController.addAction(cancleButton)
            self.present(alertController, animated: true, completion: nil)
        }
    
    func click(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(LkViewController.actionSheet))
        avatarViewController.isUserInteractionEnabled = true
        avatarViewController.addGestureRecognizer(gesture)
    }

    
    func loadAvatar(typeImage: UIImagePickerControllerSourceType){
        picker.allowsEditing = false
        picker.sourceType = typeImage
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: typeImage)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)

    }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        avatarViewController.contentMode = .scaleAspectFit
        avatarViewController.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

 

}
