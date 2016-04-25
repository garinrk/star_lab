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
    
    func Start(){
        gyroManger.accelerometerUpdateInterval = 1/60.0
        
        //start recording data
        gyroManger.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.HandleAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
    }
    
    func HandleAccData(acc : CMAcceleration){
        delegate?.UpdatePlayerPosition(CGFloat(acc.x), magY: CGFloat(acc.y))
    }
    
}
