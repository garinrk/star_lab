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
    
    var globalPlayerX : CGFloat = 50.0
    var globalPlayerY : CGFloat = 50.0
    
    var sound:Sound!
    
    override func loadView() {
        super.loadView()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gyroView.frame = UIScreen.mainScreen().bounds
        gyroView.backgroundColor = UIColor.brownColor()
        
        movementManager.accelerometerUpdateInterval = 1/60.0
        
        //Start Recording Data

        movementManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            
            self.outputAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
       
        
        self.view.addSubview(gyroView)
        
        sound = Sound()
        sound.toggleAVPlayer()
//        a.toggleAVPlayer()
        print("play")
        
            
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
                }
                else if x > 0 {
                    self.gyroView.directionLabel.text = "Leaning Right"
                }
                
                if y > 0{
                    self.gyroView.directionLabel2.text = "Leaning Back"
                }
                
                else if y < 0{
                    self.gyroView.directionLabel2.text = "Leaning Forward"
                }
                
                self.MovePlayer(CGFloat(x), magY: CGFloat(y))
                
            })
        })
        
        
        
    }


    
    /**
     Moves the "player" cell on the gyroView based on the magnitudes of
     movement from the accelerometer
     
     - parameter magX: Magnitude of the x axis
     - parameter magY: Magnitude of the y axis
     */
    func MovePlayer(magX : CGFloat, magY : CGFloat)
    {
        //What is the player's current x and y values
        let currentX = globalPlayerX
        let currentY = globalPlayerY
        
        
        //create a new player
        let newPlayer = PlayerCell()
        newPlayer.tag = 99 //give it a tag that we will use to remove it later
        
        //calculate a new x and y based on the magnitudes
        let newX = currentX + magX * 40
        let newY = currentY - magY * 40
        
        //Set's the player's position in the view
        newPlayer.frame = CGRectMake(newX, newY, 25, 25)
        
        //remove the old player
        for view in self.gyroView.subviews{
            if view.tag == 99{
                view.removeFromSuperview()
            }
        }
        
        //add to view
        self.gyroView.addSubview(newPlayer)
        
        //save the new player's position
        globalPlayerX = newX
        globalPlayerY = newY

    }
    
       
    
}

    