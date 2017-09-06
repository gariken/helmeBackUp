//
//  checkBox.swift
//  helpMe
//
//  Created by Александр on 09.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class checkBox: UIButton {
    let checkImage = UIImage(named: "checkbox_selected")
    let unCheckImage = UIImage(named: "checkbox_empty")

    var isChecked : Bool = false {
        didSet{
            if isChecked == true{
                self.setImage(checkImage, for: .normal)
            } else{
                self.setImage(unCheckImage, for: .normal)
            }
        }
    }
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(checkBox.buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    func buttonClicked(sender: UIButton){
        if (sender == self) {
            if (isChecked == true){
                isChecked = false
            } else{
                isChecked = true
            }
        }
    }
    
    
}
