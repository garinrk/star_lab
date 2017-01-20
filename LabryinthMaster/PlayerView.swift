//
//  GyroView.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol PlayerDelegate: class {
    func getMazeCellPos(x: Int, y: Int) -> CGPoint
    func getMazeCellSize() -> CGSize
    func detectCollisionFromPlayer(square: CGRect) -> Collision
    func coinCollected(coll: Collision)
    func reportNewCollider(position: CGRect)
    func goalReached()
}

class PlayerView : UIView{
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    fileprivate let moveSpeed: CGFloat = 10.0
    
    ////////////////////////////////////////
    
    fileprivate var xPos: CGFloat = 0
    fileprivate var yPos: CGFloat = 0
    fileprivate var playerDiameter: CGFloat!
    
    var cellX: Int = 0
    var cellY: Int = 0
    
    // whether player is allowed to move in the directions indicated by pos in array:
    // canMove[0] refers to up, [1] = right, [2] = down, [3] = left
    var canMove: [Bool] = [true, true, true, true]
    
    weak var delegate: PlayerDelegate? = nil
    var enemyImage = UIImage(named: "ship.png")
    var backgroundImageView = UIImageView(frame: CGRect.zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set size of player
        playerDiameter = frame.width * 0.03
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // get rid of previous views
        for sview in subviews {
            sview.removeFromSuperview()
        }

//        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        // draw circle
        let x: CGFloat = bounds.minX + xPos
        let y: CGFloat = bounds.minY + yPos
        
        let square: CGRect = CGRect(x: x, y: y, width: playerDiameter, height: playerDiameter)
//        CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
//        CGContextFillEllipseInRect(context, square)
        backgroundImageView.frame = square
        backgroundImageView.image = enemyImage
        backgroundImageView.tag = 2017
        self.addSubview(backgroundImageView)
        
        // clear the background
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        
        // detect collisions
        if delegate != nil {
            let coll: Collision = delegate!.detectCollisionFromPlayer(square: square)
            
            canMove = [!coll.north, !coll.east, !coll.south, !coll.west]
            if coll.coin {
                delegate!.coinCollected(coll: coll)
            }
            
            if coll.goal {
                delegate!.goalReached()
            }
            
            cellX = coll.cellX
            cellY = coll.cellY
            
            delegate!.reportNewCollider(position: square)
        }
        else {
            canMove = [true, true, true, true]
        }        
    }

    func move(xMagnitude: CGFloat, yMagnitude: CGFloat) {
        
        var xMove = xMagnitude
        var yMove = -yMagnitude
        
//        print("X: \(xMove) - Y: \(yMove)")
        
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
        
        let cellOrigin: CGPoint = delegate!.getMazeCellPos(x: 0, y: 0)
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
