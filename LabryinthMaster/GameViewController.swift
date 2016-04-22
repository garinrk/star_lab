//
//  GameViewController.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController : UIViewController, GyroDelegate{
    var screenRect = UIScreen.mainScreen().bounds
    var gyroManager : Gyro?
    var gyroView : GyroView?
    var globalPlayerX : CGFloat = 50.0
    var globalPlayerY : CGFloat = 50.0
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gyroManager = Gyro()
        gyroManager?.delegate = self
        gyroManager?.Start()
        
        gyroView = GyroView()
        gyroView!.frame = screenRect
        
        gyroView!.backgroundColor = UIColor(white: 1, alpha: 0)
        self.view.addSubview(gyroView!)
        
    }
    
    /**
     Updates the player's position on the view, from the
     GyroDelegate
     
     - parameter x: magnitude in x
     - parameter y: magnitude in y
     */
    func UpdatePlayerPosition(magX: CGFloat, magY: CGFloat)
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
        newPlayer.backgroundColor = UIColor.blueColor()
        
        //remove the old player
        for view in self.gyroView!.subviews{
            if view.tag == 99{
                view.removeFromSuperview()
            }
        }
        
        //add to view
        self.gyroView!.addSubview(newPlayer)
        
        //save the new player's position
        globalPlayerX = newX
        globalPlayerY = newY
    }
}
