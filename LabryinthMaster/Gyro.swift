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
    var screenRect = UIScreen.main.bounds
    
    fileprivate var paused: Bool = false
    fileprivate var motionQueue = OperationQueue()
    
    weak var delegate : GyroDelegate? = nil
    
    func Start(){
        gyroManger.accelerometerUpdateInterval = 1/60.0
        
        //start recording data
        gyroManger.startAccelerometerUpdates(to: motionQueue) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            if !self.paused {
                self.HandleAccData(accelerometerData!.acceleration)
            }
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
    }
    
    func HandleAccData(_ acc : CMAcceleration){
        if paused {
//            motionQueue = NSOperationQueue()
            return
        }
        
//        print("UPDATE interval: \(gyroManger.accelerometerUpdateInterval)")
        
        delegate?.UpdatePlayerPosition(magX: CGFloat(acc.x), magY: CGFloat(acc.y))
    }

    func Pause(){
        paused = true
    }

    func Unpause(){
        motionQueue = OperationQueue()
        paused = false
    }
}
