//
//  GameTimer.swift
//  LabyrinthMaster
//
//  Created by Garin Richards on 4/29/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation

protocol GameTimerDelegate: class {
    func updateTime(time: Int)
}

class GameTimer{
    
    //get the timelimit from the game manager
    let timeLimit: Int
    var currentTime: Int
    var gameTimer : NSTimer!
    
    private var paused: Bool = false
    
    weak var delegate: GameTimerDelegate? = nil
    
    init(timeLimit: Int){
        self.timeLimit = timeLimit
        currentTime = timeLimit
    }
    
    func StartTimer() {
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameTimer.TimerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func TimerUpdate(){
        if paused {
            return
        }
        
        currentTime -= 1
        if timeLimit <= 0{
            StopTimer()
        }
        delegate?.updateTime(currentTime)
    }
    
    func StopTimer(){
        gameTimer.invalidate()
    }
    
    func PauseTimer() {
        paused = true
    }
    
    func UnpauseTimer() {
        paused = false
    }
    
}