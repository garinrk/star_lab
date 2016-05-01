//
//  Gyro.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

protocol GyroDelegate : class{
    func UpdatePlayerPosition(magX : CGFloat, magY: CGFloat)
}

class Gyro{
    var gyroManger = CMMotionManager()
    var screenRect = UIScreen.mainScreen().bounds
    
    private var paused: Bool = false
    private var motionQueue = NSOperationQueue()
    
    weak var delegate : GyroDelegate? = nil
    
    func Start(){
        gyroManger.accelerometerUpdateInterval = 1/60.0
        
        //start recording data
        gyroManger.startAccelerometerUpdatesToQueue(motionQueue) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            if !self.paused{
                
            
            self.HandleAccData(accelerometerData!.acceleration)
            }
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
    }
    
    func HandleAccData(acc : CMAcceleration){
        if paused {
            motionQueue = NSOperationQueue()
            return
        }
        
        delegate?.UpdatePlayerPosition(CGFloat(acc.x), magY: CGFloat(acc.y))
    }

    func Pause(){
        paused = true
    }

    func Unpause(){
        motionQueue = NSOperationQueue()
        paused = false
    }
}
