//
//  timer.swift
//  HelpMeSecurity
//
//  Created by Александр on 25.04.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import Foundation

var timer : Timer = Timer()

class Timers : NSObject {
    
    func updateTime(interval: TimeInterval)  {
      let interval = Int(interval)
      let seconds = interval % 60
      let minutes = (interval / 60) % 60
      let hours = interval/3600

    }
}
