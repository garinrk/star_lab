//
//  Gyro.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/11/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation
import CoreMotion

class Gyro {
    var gyroManager = CMMotionManager()
    var accUpdateInterval = 1/60.0
//    var gyroUpdateInterval = Double(0.01)
    
    func startGyroUpdates(){
        gyroManager.accelerometerUpdateInterval = accUpdateInterval
//        gyroManager.gyroUpdateInterval = gyroUpdateInterval
        
        
        gyroManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.HandleAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
        
//        gyroManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
//            self.HandleRotData(gyroData!.rotationRate)
//            if (NSError != nil){
//                print("\(NSError)")
//            }
//            
//            
//        })
        
    }
    
    /**
     Do things with the rotation data from the gyroscope
     
     - parameter data: CMRotationRate data
     */
    func HandleRotData(data : CMRotationRate){
        
        //do a little rounding
        let x = Double(round(1000*data.x)/1000)
        let y = Double(round(1000*data.y)/1000)
        let z = Double(round(1000*data.z)/1000)
        
        
        dispatch_async(dispatch_get_main_queue(), {
            print("Rot X: \(x.description)")
            print("Rot Y: \(y.description)")
            print("Rot Z: \(z.description)")
        })
    }
    
    /**
     Do things with the accelerometer data
     
     - parameter data: CMAcceleration data
     */
    func HandleAccData(data : CMAcceleration){
        
        //some rounding
        let x = Double(round(1000*data.x)/1000)
        let y = Double(round(1000*data.y)/1000)
        let z = Double(round(1000*data.z)/1000)
        
        
        dispatch_async(dispatch_get_main_queue(), {
            print("Acc X: \(x.description)")
            print("Acc Y: \(y.description)")
            print("Acc Z: \(z.description)")
        })
    }
    
}
