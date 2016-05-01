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
    
    weak var delegate : GyroDelegate? = nil
    var acceptedUpdatesFlag : Bool = false
    func Start(){
        acceptedUpdatesFlag = true
        gyroManger.accelerometerUpdateInterval = 1/60.0
        let queue = NSOperationQueue()
        
        //start recording data
        gyroManger.startAccelerometerUpdatesToQueue(queue) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.HandleAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
    }
    
    func HandleAccData(acc : CMAcceleration){
        if acceptedUpdatesFlag{
        delegate?.UpdatePlayerPosition(CGFloat(acc.x), magY: CGFloat(acc.y))
        }
    }
    
    func Stop(){
        acceptedUpdatesFlag = false
//        self.gyroManger.stopAccelerometerUpdates()
//        self.gyroManger.stopDeviceMotionUpdates()
    }
}
