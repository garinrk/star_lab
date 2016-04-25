//
//  EnemyView.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/13/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol EnemyViewDelegate: class {
    func getMazeDimension() -> Int
    func getMazeCellPosX(x: Int, Y y: Int) -> CGPoint
    func getMazeCellSize() -> CGSize
    func detectCollisionFromEnemy(square: CGRect) -> Collision?
//    func detectCenteredInCell(square: CGRect)
}

class EnemyView: UIView {
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    private let moveSpeed: CGFloat = 24.0
    
    ////////////////////////////////////////
    
    private var xPos: CGFloat
    private var yPos: CGFloat
    
    private var horizVelocity: CGFloat
    private var vertVelocity: CGFloat
    
    private var lastTime: NSDate
    
    private var enemyWidth: CGFloat!
    private var enemyHeight: CGFloat!
    
    weak var delegate: EnemyViewDelegate? = nil
    
    private var collided: Bool = false
    var centered: Bool = false
    private var centering: Bool = false
    
    override init(frame: CGRect) {
        horizVelocity = 0.0
        vertVelocity = 0.0
        
        lastTime = NSDate()
        
        xPos = 0
        yPos = 0
        
        super.init(frame: frame)
        
        enemyHeight = bounds.width / CGFloat(30) * 0.55
        enemyWidth = bounds.width / CGFloat(30) * 0.55
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        // draw square
        let x: CGFloat = bounds.minX + xPos
        let y: CGFloat = bounds.minY + yPos

        let square: CGRect = CGRect(x: x, y: y, width: enemyWidth, height: enemyHeight)
        CGContextSetFillColorWithColor(context, UIColor.purpleColor().CGColor)
        CGContextFillRect(context, square)
        
        // clear the background
        self.backgroundColor = UIColor(white: 1, alpha: 0)


        // update stuff
        if collided
        {
            if delegate!.detectCollisionFromEnemy(square) == nil
            {
                collided = false
                moveInRandomDirection()
            }
        }
            
        else
        {
            if delegate != nil
            {
                if delegate!.detectCollisionFromEnemy(square) != nil
                {
                    setCollision()
                }
            }
        }
    }
    
    func setCollision()
    {
        if collided
        {
            return
        }
        else {
            collided = true
            horizVelocity *= -1
            vertVelocity *= -1
        }
        
    }
    
    func start()
    {
        if delegate == nil {
            return
        }
        
        randomizeLocation()
        moveInRandomDirection()
    }
    
    
    func randomizeLocation()
    {
        let dimension: Int = delegate!.getMazeDimension()
        let cellSize: CGSize = delegate!.getMazeCellSize()
        
        let cellX = Int(arc4random_uniform(UInt32(dimension)))
        let cellY = Int(arc4random_uniform(UInt32(dimension)))
        
        let cellOrigin: CGPoint = delegate!.getMazeCellPosX(cellX, Y: cellY)
        
        let halfDifferenceWidth: CGFloat = (cellSize.width - enemyWidth) * 0.5
        let halfDifferenceHeight: CGFloat = (cellSize.height - enemyHeight) * 0.5
        
        xPos = cellOrigin.x + halfDifferenceWidth
        yPos = cellOrigin.y + halfDifferenceHeight
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
        let deltaTime: CGFloat = CGFloat(currentTime.timeIntervalSinceDate(lastTime))
        lastTime = currentTime
        
        yPos += horizVelocity * deltaTime
        xPos += vertVelocity * deltaTime
        
        setNeedsDisplay()
    }
}
