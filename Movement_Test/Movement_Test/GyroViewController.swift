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
    var gyroView : GyroView = GyroView()
    
    
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gyroView.frame = UIScreen.mainScreen().bounds
            gyroView.backgroundColor = UIColor.brownColor()
            
            movementManager.gyroUpdateInterval = 0.01
            movementManager.accelerometerUpdateInterval = 0.01
            
            //Start Recording Data

        
        
        self.view.addSubview(gyroView)
            
            
    }
    
    
    /**
     Update the labels in the view to show the rounded values
     of the acceleration data
     
     - parameter acceleration: <#acceleration description#>
     */
    func outputAccData(acceleration: CMAcceleration){
        
        let x = Double(round(1000*acceleration.x)/1000)
        let y = Double(round(1000*acceleration.y)/1000)
        let z = Double(round(1000*acceleration.z)/1000)
        
     
        
        dispatch_async(dispatch_get_main_queue(), {
            dispatch_async(dispatch_get_main_queue(), {
                self.gyroView.accXLabel.text = "Acc x: \(x.description)"
                self.gyroView.accYLabel.text = "Acc y: \(y.description)"
                self.gyroView.accZLabel.text = "Acc z: \(z.description)"
            })
        })
        
        
        
    }

    /**
     Update the labels in the view to show the rounded values of the rotation
     data from the gyroscpe
     
     - parameter rotation: CMRotatoinRate data
     */
    func outputRotData(rotation: CMRotationRate){
        
        let x = Double(round(1000*rotation.x)/1000)
        let y = Double(round(1000*rotation.y)/1000)
        let z = Double(round(1000*rotation.z)/1000)
        
        
        dispatch_async(dispatch_get_main_queue(), {
            self.gyroView.rollLabel.text = "Rot x: \(x.description)"
            self.gyroView.pitchLabel.text = "Rot y: \(y.description)"
            self.gyroView.yawLabel.text = "Rot z: \(z.description)"
        })
        
        
        
    }
    
       
    
}

    