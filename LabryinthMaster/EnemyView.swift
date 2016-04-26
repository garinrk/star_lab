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
    func getMazeCellAtX(x: Int, Y y: Int) -> MazeViewCell?
    func getMazeCellSize() -> CGSize
    func detectCollisionFromEnemy(square: CGRect) -> Collision
//    func detectCenteredInCell(square: CGRect)
}

class EnemyView: UIView {
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    private let moveSpeed: CGFloat = 24.0
    
    // 0 = totally random, 1 = avoids walls, 2 = AStar
    let AIType: Int = 0
    
    ////////////////////////////////////////
    
    private var xPos: CGFloat
    private var yPos: CGFloat
    
    private var _cellX: Int = 0
    private var _cellY: Int = 0
    private var cellX: Int {
        get {
            return _cellX
        }
        set {
            if newValue != _cellX
            {
                _cellX = newValue
                enteredNewCell = true
            }
        }
    }
    private var cellY: Int {
        get {
            return _cellY
        }
        set {
            if newValue != _cellY
            {
                _cellY = newValue
                enteredNewCell = true
            }

        }
    }
    
    private var horizVelocity: CGFloat
    private var vertVelocity: CGFloat
    
    private var lastTime: NSDate
    
    private var enemyWidth: CGFloat!
    private var enemyHeight: CGFloat!
    
    weak var delegate: EnemyViewDelegate? = nil
    
    private var enteredNewCell: Bool = false
    private var collided: Bool = false
//    var centered: Bool = false
//    private var centering: Bool = false
    
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


        // check for collisions
        
        if delegate != nil
        {
            let coll: Collision = delegate!.detectCollisionFromEnemy(square)
            self.cellX = coll.cellX
            self.cellY = coll.cellY
            
            // for type 1 AI
            if AIType == 1
            {
                if enteredNewCell
                {
                    enteredNewCell = false
                    moveInRandomDirectionAvoidingWalls()
                }
            }
            
            // for type 0 AI
            
            if collided {
                if coll.east || coll.north || coll.south || coll.west
                {
                    return
                }
                else
                {
                    collided = false
                    moveInRandomDirection()
                }
            }
            else if coll.east || coll.north || coll.south || coll.west
            {
                setCollision()
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
        
        switch AIType {
        case 0:
            moveInRandomDirection()
            break
        case 1:
            moveInRandomDirectionAvoidingWalls()
            break
        case 2:
            break
        default:
            break
        }
        
    }
    
    
    func randomizeLocation()
    {
        let dimension: Int = delegate!.getMazeDimension()
        let cellSize: CGSize = delegate!.getMazeCellSize()
        
        let cellX = Int(arc4random_uniform(UInt32(dimension)))
        let cellY = Int(arc4random_uniform(UInt32(dimension)))
        
        self.cellX = cellX
        self.cellY = cellY
        
        let cellOrigin: CGPoint = delegate!.getMazeCellPosX(cellX, Y: cellY)
        
        let halfDifferenceWidth: CGFloat = (cellSize.width - enemyWidth) * 0.5
        let halfDifferenceHeight: CGFloat = (cellSize.height - enemyHeight) * 0.5
        
        xPos = cellOrigin.x + halfDifferenceWidth
        yPos = cellOrigin.y + halfDifferenceHeight
    }
    
    func moveInRandomDirection()
    {
        let dir: Int = Int(arc4random_uniform(4))
        moveInDirection(dir)
    }
    
    func moveInRandomDirectionAvoidingWalls()
    {
        // first get possible directions
        if delegate == nil{
            return
        }
        
        let cell: MazeViewCell? = delegate!.getMazeCellAtX(self.cellX, Y: self.cellY)
        if cell == nil {
            return
        }
        
        var possibleDirections: [Int] = []
        
        if !cell!.north
        {
            possibleDirections.append(0)
        }
        if !cell!.east
        {
            possibleDirections.append(1)
        }
        if !cell!.south
        {
            possibleDirections.append(2)
        }
        if !cell!.west
        {
            possibleDirections.append(3)
        }
        
        // choose a random direction from the possibilities
        let dirIndex: Int = Int(arc4random_uniform(UInt32(possibleDirections.count)))
        
        moveInDirection(possibleDirections[dirIndex])
    }
    
    private func moveInDirection(direction: Int)
    {
        switch direction {
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
