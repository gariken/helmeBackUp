//
//  checkVyzov.swift
//  HelpMeSecurity
//
//  Created by Александр on 22.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
//MARK: Обрабочик собыйти для кнопки, для испольование присвоить в класс объекта

class checkVyzov: UIButton {

        let checkImage = UIImage(named: "prinyat")
        let unCheckImage = UIImage(named: "endVyzov")
        
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
            self.addTarget(self, action: #selector(checkVyzov.buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        }
        
        func buttonClicked(sender: UIButton){
            if (sender == self) {
                if (isChecked == false){
                    isChecked = true
                } else{
                    isChecked = false
                }
            }
        
    }

}
