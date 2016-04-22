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
//    var playerView = PlayerView()
    var screenRect = UIScreen.mainScreen().bounds
    
    var globalPlayerX : CGFloat = 50.0
    var globalPlayerY : CGFloat = 50.0
    
    weak var delegate : GyroDelegate? = nil
    
    func Start(){
//        playerView.backgroundColor = UIColor(white: 1, alpha: 0)
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
        //        self.MovePlayer(CGFloat(acc.x), magY: CGFloat(acc.y))
    }
    
    /**
     Set the player's position on the playerview
     
     - parameter magX: magntidue of x movement
     - parameter magY: magnitude of y movement
     */
    //    func MovePlayer(magX : CGFloat, magY : CGFloat)
    //    {
    //
    //        //What is the player's current x and y values
    //        let currentX = globalPlayerX
    //        let currentY = globalPlayerY
    //
    //
    //        //create a new player
    //        let newPlayer = PlayerCell()
    //        newPlayer.tag = 99 //give it a tag that we will use to remove it later
    //
    //        //calculate a new x and y based on the magnitudes
    //        let newX = currentX + magX * 40
    //        let newY = currentY - magY * 40
    //
    //        //Set's the player's position in the view
    //        newPlayer.frame = CGRectMake(newX, newY, 25, 25)
    //
    //        //remove the old player
    //        for view in self.gyroView.subviews{
    //            if view.tag == 99{
    //                view.removeFromSuperview()
    //            }
    //        }
    //
    //        //add to view
    //        self.gyroView.addSubview(newPlayer)
    //
    //        //save the new player's position
    //        globalPlayerX = newX
    //        globalPlayerY = newY
    //    }
}
