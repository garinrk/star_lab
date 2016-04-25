//
//  GyroView.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol PlayerDelegate: class {
    func detectCollisionFromPlayer(square: CGRect) -> Collision?
}

class PlayerView : UIView{
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    private let moveSpeed: CGFloat = 40.0
    
    ////////////////////////////////////////
    
    private var xPos: CGFloat
    private var yPos: CGFloat
    private var playerDiameter: CGFloat!
    
    // whether player is allowed to move in the directions indicated by pos in array:
    // canMove[0] refers to up, [1] = right, [2] = down, [3] = left
    var canMove: [Bool] = [true, true, true, true]
    
    weak var delegate: PlayerDelegate? = nil

    override init(frame: CGRect) {
        
        xPos = 0
        yPos = 0
        
        super.init(frame: frame)
        
        playerDiameter = frame.width * 0.025
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        // draw circle
        let x: CGFloat = bounds.minX + xPos
        let y: CGFloat = bounds.minY + yPos
        
        let square: CGRect = CGRect(x: x, y: y, width: playerDiameter, height: playerDiameter)
        CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextFillEllipseInRect(context, square)
        
        // clear the background
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        
        // detect collisions
        let coll: Collision? = delegate?.detectCollisionFromPlayer(square)
        if coll != nil {
            canMove = [coll!.north, coll!.east, coll!.south, coll!.west]
        }
        else {
            canMove = [true, true, true, true]
        }
        
    }

    func moveX(xMagnitude: CGFloat, Y yMagnitude: CGFloat) {
        
        var xMove = xMagnitude
        var yMove = yMagnitude
        
        // first check to see if moves are allowed
        
        if yMagnitude < 0 { // up
            if canMove[0] == false {
                yMove = 0
            }
        }
        
        if xMagnitude > 0 { // right
            if canMove[1] == false {
                xMove = 0
            }
        }
        
        if yMagnitude > 0 { // down
            if canMove[2] == false {
                yMove = 0
            }
        }
        
        if xMagnitude < 0 { // left
            if canMove[3] == false {
                xMove = 0
            }
        }
        
        xPos += xMove * moveSpeed
        yPos += yMove * moveSpeed
    }
    
    func update()
    {
        setNeedsDisplay()
    }
}
