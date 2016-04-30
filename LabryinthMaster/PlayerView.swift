//
//  GyroView.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol PlayerDelegate: class {
    func getMazeCellPosX(x: Int, Y y: Int) -> CGPoint
    func getMazeCellSize() -> CGSize
    func detectCollisionFromPlayer(square: CGRect) -> Collision
    func coinCollected()
    func reportNewColliderPosition(position: CGRect)
}

class PlayerView : UIView{
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    private let moveSpeed: CGFloat = 10.0
    
    ////////////////////////////////////////
    
    private var xPos: CGFloat = 0
    private var yPos: CGFloat = 0
    private var playerDiameter: CGFloat!
    
    var cellX: Int = 0
    var cellY: Int = 0
    
    // whether player is allowed to move in the directions indicated by pos in array:
    // canMove[0] refers to up, [1] = right, [2] = down, [3] = left
    var canMove: [Bool] = [true, true, true, true]
    
    weak var delegate: PlayerDelegate? = nil

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // set size of player
        
        playerDiameter = frame.width * 0.02
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
        if delegate != nil {
            let coll: Collision = delegate!.detectCollisionFromPlayer(square)
            
            canMove = [!coll.north, !coll.east, !coll.south, !coll.west]
            if coll.coin {
                delegate!.coinCollected()
            }
            
            cellX = coll.cellX
            cellY = coll.cellY
            
            delegate!.reportNewColliderPosition(rect)
        }
        else {
            canMove = [true, true, true, true]
        }
        
    }

    func moveX(xMagnitude: CGFloat, Y yMagnitude: CGFloat) {
        
        var xMove = xMagnitude
        var yMove = -yMagnitude
        
        // first check to see if moves are allowed
        
        if yMove < 0 { // up
            if canMove[0] == false {
                yMove = 0
            }
        }
        
        if xMove > 0 { // right
            if canMove[1] == false {
                xMove = 0
            }
        }
        
        if yMove > 0 { // down
            if canMove[2] == false {
                yMove = 0
            }
        }
        
        if xMove < 0 { // left
            if canMove[3] == false {
                xMove = 0
            }
        }
        
        xPos += xMove * moveSpeed
        yPos += yMove * moveSpeed
    }
    
    func start()
    {
        // put player in the center of cell 0,0
        
        let cellOrigin: CGPoint = delegate!.getMazeCellPosX(0, Y: 0)
        let cellSize: CGSize = delegate!.getMazeCellSize()
        
        let halfDifferenceWidth: CGFloat = (cellSize.width - playerDiameter) * 0.5
        let halfDifferenceHeight: CGFloat = (cellSize.height - playerDiameter) * 0.5
        
        xPos = cellOrigin.x + halfDifferenceWidth
        yPos = cellOrigin.y + halfDifferenceHeight
    }
    
    func update()
    {
        setNeedsDisplay()
    }
}
