//
//  GyroViewController.swift
//  Movement_Test
//
//  Created by Garin Richards on 4/10/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
import CoreMotion

class GyroViewController : UIViewController{
    
    
    var movementManager = CMMotionManager()
    
    
    
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

            
            
            movementManager.gyroUpdateInterval = 0.2
            movementManager.accelerometerUpdateInterval = 0.2
            
            //Start Recording Data
            
//            movementManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
//                
//                self.outputAccData(accelerometerData!.acceleration)
//                if(NSError != nil) {
//                    print("\(NSError)")
//                }
//            }
        
            movementManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
                self.outputRotData(gyroData!.rotationRate)
                if (NSError != nil){
                    print("\(NSError)")
                }
                
                
            })
            
            
    }
    
    func outputAccData(acceleration: CMAcceleration){
        
     
        
        print("ACC:\(acceleration.x).2f,\(acceleration.y).2f,\(acceleration.z).2f")
        
        
    }

    func outputRotData(rotation: CMRotationRate){
        
        
        
        
       print("ROT:\(rotation.x).2f,\(rotation.y).2f,\(rotation.z).2f")
        
        
        
    }
    
       
    
}

    