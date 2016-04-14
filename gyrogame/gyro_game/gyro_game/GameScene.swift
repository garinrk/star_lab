//
//  GameScene.swift
//  gyro_game
//
//  Created by Garin Richards on 4/14/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene : SKScene{
    
    let manager = CMMotionManager()
    
    override func didMoveToView(view: SKView) {
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()){
            (data,error) in
            
            self.physicsWorld.gravity = CGVectorMake(CGFloat((data?.acceleration.x)!),CGFloat((data?.acceleration.y)!))
            
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
}
