//
//  EnemyView.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/13/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

protocol EnemyViewDelegate: class {
    func getMazeDimension() -> Int
    func getMazeCellPos(x: Int, y: Int) -> CGPoint
    func getMazeCellAt(x: Int, y: Int) -> MazeViewCell?
    func getMazeCellSize() -> CGSize
    func detectCollisionFromEnemy(square: CGRect) -> Collision
	func getPlayerCell() -> MazeViewCell
    func reportPlayerCollision()
}

class EnemyView: UIView {
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    fileprivate let moveSpeed: CGFloat = 24.0
	
	// 0 = totally dumb
	// 1 = avoid walls
	// 2 = move toward player (A star)
	var AIMode: Int = 1
    
    ////////////////////////////////////////
    
    fileprivate var xPos: CGFloat
    fileprivate var yPos: CGFloat
    
    fileprivate var cellX: Int = 0
    fileprivate var cellY: Int = 0
    
    fileprivate var horizVelocity: CGFloat
    fileprivate var vertVelocity: CGFloat
    
    fileprivate var lastTime: Date
    
    fileprivate var enemyWidth: CGFloat!
    fileprivate var enemyHeight: CGFloat!
    
    fileprivate var playerCollisionBox: CGRect!
    
    weak var delegate: EnemyViewDelegate? = nil
    
    fileprivate var collided: Bool = false
    var enemyImage = UIImage(named: "alien.png")
    var backgroundImageView = UIImageView(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        horizVelocity = 0.0
        vertVelocity = 0.0
        
        lastTime = Date()
        
        xPos = 0
        yPos = 0
        
        super.init(frame: frame)
        
        enemyHeight = bounds.width / CGFloat(30) * 0.80
        enemyWidth = bounds.width / CGFloat(30) * 0.80
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
        
        // draw square
        let x: CGFloat = bounds.minX + xPos
        let y: CGFloat = bounds.minY + yPos

        let square: CGRect = CGRect(x: x, y: y, width: enemyWidth, height: enemyHeight)
//        CGContextSetFillColorWithColor(context, UIColor.purpleColor().CGColor)
//        CGContextFillRect(context, square)
        
        backgroundImageView.frame = square
        backgroundImageView.image = enemyImage
        backgroundImageView.tag = 2016
        self.addSubview(backgroundImageView)
        
        // clear the background
        self.backgroundColor = UIColor(white: 1, alpha: 0)

        // check for collisions
        
        if delegate != nil
        {
            let coll: Collision = delegate!.detectCollisionFromEnemy(square: square)
            self.cellX = coll.cellX
            self.cellY = coll.cellY
            
            // for type 1 AI
            if AIMode == 1
            {
                if coll.centeredX || coll.centeredY
                {
                    moveInRandomDirectionAvoidingWalls()
                }
            }
            
            if AIMode == 2
            {
                if coll.centeredX || coll.centeredY
                {
                    moveTowardPlayer()
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
            
            // check for player collision
            if playerCollisionBox != nil {
                
                if playerCollisionBox.midX >= square.minX && playerCollisionBox.midX <= square.maxX
                {
                    if playerCollisionBox.midY >= square.minY && playerCollisionBox.midY <= square.maxY
                    {
                        delegate!.reportPlayerCollision()
                    }
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
        
        switch AIMode {
        case 0:
            moveInRandomDirection()
            break
        case 1:
            moveInRandomDirectionAvoidingWalls()
            break
        case 2:
            moveTowardPlayer()
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
        
        let cellOrigin: CGPoint = delegate!.getMazeCellPos(x: cellX, y: cellY)
        
        let halfDifferenceWidth: CGFloat = (cellSize.width - enemyWidth) * 0.5
        let halfDifferenceHeight: CGFloat = (cellSize.height - enemyHeight) * 0.5
        
        xPos = cellOrigin.x + halfDifferenceWidth
        yPos = cellOrigin.y + halfDifferenceHeight
    }
    
    func moveInRandomDirection()
    {
        let dir: Int = Int(arc4random_uniform(4))
        moveIn(direction: dir)
    }
    
    func moveInRandomDirectionAvoidingWalls()
    {
        // first get possible directions
        if delegate == nil{
            return
        }
        
        let cell: MazeViewCell? = delegate!.getMazeCellAt(x: self.cellX, y: self.cellY)
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
        
        moveIn(direction: possibleDirections[dirIndex])
    }
    
	fileprivate func manhattanDistance(a: MazeViewCell, b: MazeViewCell) -> Int
	{
		return abs(a.x - b.x) + abs(a.y - b.y)
	}
	
	fileprivate func neighborDirections(cell: MazeViewCell) -> [Int]
	{
		var result: [Int] = []
		
		if !cell.north
		{
			result.append(0)
		}
		if !cell.east
		{
			result.append(1)
		}
		if !cell.south
		{
			result.append(2)
		}
		if !cell.west
		{
			result.append(3)
		}
		
		return result
	}
	
	func moveTowardPlayer()
	{
		if delegate == nil
		{
			return
		}
		
		// DO A Star pathfinding
		
		let playerCell: MazeViewCell = delegate!.getPlayerCell()
	
		let frontier: MazeViewCellPriorityQueue = MazeViewCellPriorityQueue()

		// add current cell
        let currentCell: MazeViewCell? = delegate!.getMazeCellAt(x: self.cellX, y: self.cellY)
        if currentCell == nil {
            return
        }
        
		frontier.addCell(cell: currentCell!, priority: 1)
		
        var cameFrom: [String : MazeViewCell?] = ["\(self.cellX),\(self.cellY)" : nil]
        var costSoFar: [String : Int] = ["\(self.cellX),\(self.cellY)" : 0]
		
		while !frontier.empty
		{
			let current: MazeViewCell? = frontier.next()
			
			if current == nil || current == playerCell
			{
				break
			}
			
			for cell in neighborDirections(cell: current!)
			{
				let newCost: Int = costSoFar["\(current!.x),\(current!.y)"]! + 1
				
                var cellLocString: String = ""
                var nextCell: MazeViewCell? = nil
                switch cell
                {
                case 0:
                    cellLocString = "\(current!.x),\(current!.y - 1)"
                    nextCell = delegate!.getMazeCellAt(x: current!.x, y: current!.y - 1)
                    break
                case 1:
                    cellLocString = "\(current!.x + 1),\(current!.y)"
                    nextCell = delegate!.getMazeCellAt(x: current!.x + 1, y: current!.y)
                    break
                case 2:
                    cellLocString = "\(current!.x),\(current!.y + 1)"
                    nextCell = delegate!.getMazeCellAt(x: current!.x, y: current!.y + 1)
                    break
                case 3:
                    cellLocString = "\(current!.x - 1),\(current!.y)"
                    nextCell = delegate!.getMazeCellAt(x: current!.x - 1, y: current!.y)
                    break
                default:
                    break
                }
                
                if nextCell == nil
                {
                    return
                }
                
                let costToCell: Int? = costSoFar[cellLocString]

				if costToCell == nil || newCost < costToCell // TODO: fixme
				{
					costSoFar[cellLocString] = newCost
                    let priority: Int = newCost + manhattanDistance(a: currentCell!, b: nextCell!)
					frontier.addCell(cell: nextCell!, priority: priority)
					cameFrom[cellLocString] = current
				}
			}			
		}		
		
		// now trace our way back to find the step to take
        let myCell: MazeViewCell? = delegate!.getMazeCellAt(x: cellX, y: cellY)
        if myCell == nil
        {
            return
        }
		
		var nextStep: MazeViewCell = playerCell
		
		while cameFrom["\(nextStep.x),\(nextStep.y)"]! != myCell!
		{
			let tempCell: MazeViewCell! = cameFrom["\(nextStep.x),\(nextStep.y)"]!
		
            nextStep = delegate!.getMazeCellAt(x: tempCell.x, y: tempCell.y)!
		}
		
        moveToward(cell: nextStep)
	}
	
	fileprivate func moveToward(cell: MazeViewCell)
	{
		if cellX < cell.x
		{
            moveIn(direction: 4)
		}
		else if cellX > cell.x
		{
			moveIn(direction: 1)
		}
		else if cellY > cell.y
		{
			moveIn(direction: 3)
		}
		else if cellY < cell.y
		{
			moveIn(direction: 0)
		}		
	}
	
    fileprivate func moveIn(direction: Int)
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

    func updatePlayerCollision(location: CGRect)
    {
        playerCollisionBox = location
    }

    func update()
    {
        let currentTime: Date = Date()
        let deltaTime: CGFloat = CGFloat(currentTime.timeIntervalSince(lastTime))
        lastTime = currentTime
        
//        print ("deltaTime: \(deltaTime)")
        
        yPos += horizVelocity * deltaTime
        xPos += vertVelocity * deltaTime
        
        setNeedsDisplay()
    }
}
