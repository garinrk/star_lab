//
//  Enemy.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/13/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation

protocol EnemyDelegate: class {
    func getMazeDimension() -> Int
    func enemyXChanged(enemy: Enemy, x: Float)
    func enemyYChanged(enemy: Enemy, y: Float)
}

class Enemy
{
    
    private var _xPos: Float = 0.5
    var xPos: Float {
        get {
            return _xPos
        }
        set {
            _xPos = newValue
            delegate?.enemyXChanged(self, x: _xPos)
        }
    }
    
    private var _yPos: Float = 0.5
    var yPos: Float {
        get {
            return _yPos
        }
        set {
            _yPos = newValue
            delegate?.enemyYChanged(self, y: _yPos)
        }
    }
    
    private var horizVelocity: Float
    private var vertVelocity: Float
    
    private var lastTime: NSDate
    
    private var moveSpeed: Float = 2.0
    
    weak var delegate: EnemyDelegate? = nil
    
    var collided: Bool = false
    
    init() {
        horizVelocity = 0.0
        vertVelocity = 0.0
        
        lastTime = NSDate()
        moveInRandomDirection()
    }
    
    func randomizeLocation()
    {
        if delegate == nil {
            return
        }
        
        let dimension: Int = delegate!.getMazeDimension()
        
        xPos = Float(arc4random_uniform(UInt32(dimension)))
        yPos = Float(arc4random_uniform(UInt32(dimension)))
    }
    
    func moveInRandomDirection()
    {
        let dir: Int = Int(arc4random_uniform(4))
        switch dir {
        case 0:
            horizVelocity = 0.0
            vertVelocity = -moveSpeed
            break
        case 1:
            horizVelocity = moveSpeed
            vertVelocity = 0.0
            break
        case 2:
            horizVelocity = 0.0
            vertVelocity = moveSpeed
            break
        case 3:
            horizVelocity = -moveSpeed
            vertVelocity = 0.0
            break
        default:
            break
        }
        
    }
    
    func update()
    {
        let currentTime: NSDate = NSDate()
        let deltaTime: Float = Float(currentTime.timeIntervalSinceDate(lastTime))
        lastTime = currentTime
        
//        collided = false
        
        if collided
        {
            moveInRandomDirection()
            collided = false
        }
        else
        {
            yPos += horizVelocity * deltaTime
            xPos += vertVelocity * deltaTime
        }
    }
    
    
}