//
//  StoryBoardGo.swift
//  helpMe
//
//  Created by Александр on 22.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit


class StoryBoardGo {
    func go(identifer: String, view: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifer)
        view.present(vc, animated: true, completion: nil)
    }
}
