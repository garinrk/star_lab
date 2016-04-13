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
    func enemyXChanged(enemy: Enemy, x: Int)
    func enemyYChanged(enemy: Enemy, y: Int)
}

class Enemy
{
    
    private var _xPos: Int = 0
    var xPos: Int {
        get {
            return _xPos
        }
        set {
            _xPos = newValue
            delegate?.enemyXChanged(self, x: _xPos)
        }
    }
    
    private var _yPos: Int = 0
    var yPos: Int {
        get {
            return _yPos
        }
        set {
            _xPos = newValue
            delegate?.enemyYChanged(self, y: _yPos)
        }
    }
    
    private var horizVelocity: Float
    private var vertVelocity: Float
    
    private var moveSpeed: Float = 0.0
    
    weak var delegate: EnemyDelegate? = nil
    
    init() {
        horizVelocity = 0.0
        vertVelocity = 0.0
    }
    
    func randomizeLocation()
    {
        if delegate == nil {
            return
        }
        
        let dimension: Int = delegate!.getMazeDimension()
        
        xPos = Int(arc4random_uniform(UInt32(dimension)))
        yPos = Int(arc4random_uniform(UInt32(dimension)))
    }
    
    
}