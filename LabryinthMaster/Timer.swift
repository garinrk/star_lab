//
//  Timer.swift
//  Movement_Test
//
//  Created by Garin Richards on 4/29/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation

class Timer{
    
    //get the timelimit from the game manager
    var timeLimit = 10
    var gameTimer : NSTimer!
    
    init(){
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Timer.TimerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func TimerUpdate(){
        timeLimit -= 1
        print("time: \(timeLimit)")
        if timeLimit <= 5{
            StopTimer()
        }
        print("Update")
        
    }
    
    func StopTimer(){
        gameTimer.invalidate()
        
    }
    
}