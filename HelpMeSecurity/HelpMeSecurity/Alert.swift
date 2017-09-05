//
//  Alert.swift
//  HelpMeSecurity
//
//  Created by Александр on 28.04.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import Foundation
import UIKit

//MARK: Стандартное всплывающие окно
class AlertStandart{
    func show(_ textTitle: String, text: String, view: UIViewController) {
        let action = UIAlertController(title: "\(textTitle)", message: "\(text)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "ОК", style: .default, handler: nil)
        action.addAction(actionOk)
        view.present(action, animated: true, completion: nil)
    }
}
