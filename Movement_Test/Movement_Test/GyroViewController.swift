//
//  GyroViewController.swift
//  Movement_Test
//
//  Created by Garin Richards on 4/10/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
import CoreMotion

enum PlayerDirection {
    case LEFT
    case RIGHT
    case UP
    case DOWN
}

class GyroViewController : UIViewController{
    
    
    var movementManager = CMMotionManager()
    var gyroView : GyroView = GyroView()
    var player : PlayerCell?
    
    
    override func loadView() {
        super.loadView()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gyroView.frame = UIScreen.mainScreen().bounds
        gyroView.backgroundColor = UIColor.brownColor()
        
        movementManager.gyroUpdateInterval = 0.5
        movementManager.accelerometerUpdateInterval = 0.5
        
        //Start Recording Data

        movementManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.outputAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
        
        movementManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
            self.outputRotData(gyroData!.rotationRate)
            if (NSError != nil){
                print("\(NSError)")
            }
            
            
        })
        
        
        self.view.addSubview(gyroView)
//        player.frame = CGRectMake(50, 50, 25, 25)
        
//        player.backgroundColor = UIColor.greenColor()
//        self.view.addSubview(player)
        
            
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
                
                if x < 0{
                    self.gyroView.directionLabel.text = "Leaning Left"
                    self.MovePlayer(.LEFT, magnitude: x)
                }
                else if x > 0 {
                    self.gyroView.directionLabel.text = "Leaning Right"
                    self.MovePlayer(.RIGHT, magnitude: x)
                }
                
                else if y > 0{
                    self.gyroView.directionLabel2.text = "Leaning Back"
                    self.MovePlayer(.UP, magnitude: y)
                }
                
                else if y < 0{
                    self.gyroView.directionLabel2.text = "Leaning Forward"
                    self.MovePlayer(.DOWN, magnitude: y)
                }
                
                
            })
        })
        
        
        
    }

    /**
     Update the labels in the view to show the rounded values of the rotation
     data from the gyroscpe
     
     - parameter rotation: CMRotatoinRate data
     */
    func outputRotData(rotation: CMRotationRate){
        
//        let x = Double(round(1000*rotation.x)/1000)
//        let y = Double(round(1000*rotation.y)/1000)
//        let z = Double(round(1000*rotation.z)/1000)
        
        
 
        
        
        
    }
    
    func MovePlayer(direction : PlayerDirection, magnitude : Double)
    {
        var origx : CGFloat = 50.0
        var origy : CGFloat = 50.0
        var newPlayer = PlayerCell()
        
        
        var newX : CGFloat
        var newY : CGFloat
        
        if direction == .DOWN{
            

            newY = origy + CGFloat(magnitude)
            newPlayer.frame = CGRectMake(origx, newY, 50, 50)
            self.gyroView.willRemoveSubview(player!)
            self.gyroView.addSubview(newPlayer)
        }
        else if direction == .UP{
            
            newY = origy - CGFloat(magnitude)
            newPlayer.frame = CGRectMake(origx, newY, 50, 50)
            self.gyroView.addSubview(newPlayer)
            
        }
        else if direction == .LEFT{
            
            newX = origx - CGFloat(magnitude)
            newPlayer.frame = CGRectMake(newX, origy, 50, 50)
            self.gyroView.addSubview(newPlayer)
            
        }
        else if direction == .RIGHT{
            newX = origx + CGFloat(magnitude)
            newPlayer.frame = CGRectMake(newX, origy, 50, 50)
            self.gyroView.addSubview(newPlayer)
            
            
        }
        
//        self.player.frame = CGRectMake(50, 50, 25, 25)
    }
    
       
    
}

    