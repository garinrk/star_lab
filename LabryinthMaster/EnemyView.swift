//
//  EnemyView.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/13/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

// TODO: move this to its own file:::
struct MazeViewCellPriorityQueueNode
{
	let object: MazeViewCell
	let priority: Int
}

class MazeViewCellPriorityQueue 
{
	private var queue: [MazeViewCellPriorityQueueNode] = []
	var empty: Bool 
	{
		return queue.isEmpty
	}
	
	func next() -> MazeViewCell?
	{
		var result: MazeViewCell? = queue.removeAtIndex(0)?.object
		return result
	}
	
	func addCell(cell: MazeViewCell, WithPriority priority: Int)
	{
		let newNode: MazeViewCellPriorityQueueNode = MazeViewCellPriorityQueueNode(object: cell, priority: priority)
		
		queue.append(newNode)
		
		// bubble new item up by priority
		var keepGoing: Bool = true
		var i: Int = queue.count - 1
		while keepGoing && i > 0{
			if queue[i].priority > queue[i-1].priority
			{
				let tmp: MazeViewCellPriorityQueueNode = queue[i-1]
				
				queue[i-1] = queue[i]
				queue[i] = tmp
				
				i-=1
			}
			else
			{
				keepGoing = false
			}			
		}
	}
}


protocol EnemyViewDelegate: class {
    func getMazeDimension() -> Int
    func getMazeCellPosX(x: Int, Y y: Int) -> CGPoint
    func getMazeCellAtX(x: Int, Y y: Int) -> MazeViewCell?
    func getMazeCellSize() -> CGSize
    func detectCollisionFromEnemy(square: CGRect) -> Collision
//    func detectCenteredInCell(square: CGRect)
	func getPlayerCell() -> MazeViewCell
}

class EnemyView: UIView {
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    private let moveSpeed: CGFloat = 24.0
	
	// 0 = totally dumb
	// 1 = avoid walls
	// 2 = move toward player (A star)
	private let AIMode: Int = 1
    
    ////////////////////////////////////////
    
    private var xPos: CGFloat
    private var yPos: CGFloat
    
    private var cellX: Int
    private var cellY: Int
    
    private var horizVelocity: CGFloat
    private var vertVelocity: CGFloat
    
    private var lastTime: NSDate
    
    private var enemyWidth: CGFloat!
    private var enemyHeight: CGFloat!
    
    weak var delegate: EnemyViewDelegate? = nil
    
    private var collided: Bool = false
//    var centered: Bool = false
//    private var centering: Bool = false
    
    override init(frame: CGRect) {
        horizVelocity = 0.0
        vertVelocity = 0.0
        
        lastTime = NSDate()
        
        xPos = 0
        yPos = 0
        
        cellX = 1
        cellY = 1
        
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
            
			if AIMode == 0 {
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
			
			if AIMode == 1 {
				if coll.centered
				{
					moveInRandomDirectionAvoidingWalls()
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
		
		switch AIMode
		{
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
    
	private func manhattanDistance(a: MazeViewCell, ToB b: MazeViewCell) -> CGFloat
	{
		return abs(a.x - b.x) + abs(a.y - b.y)	
	}
	
	private func neighborDirections(cell: MazeViewCell) -> [Int]
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
	
		var frontier: MazeViewCellPriorityQueue = MazeViewCellPriorityQueue()

		// add current cell
		frontier.addCell(delegate!.getMazeCellAtX(self.cellX, Y: self.cellY), priority: 1)
		
		var cameFrom: [String, MazeViewCell?] = ["\(self.cellX),\(self.cellY)",nil]
		var costSoFar: [String, Int] = ["\(self.cellX),\(self.cellY)",0]
		
		while !frontier.empty
		{
			let current: MazeViewCell = frontier.next()
			
			if current == playerCell
			{
				break
			}
			
			for cell in neighborDirections(current)
			{
				var newCost: Int = costSoFar["\(current.x),\(current.y)"] + 1
				
				let costToCell: Int? = costSoFar["\(cell.x),\(cell.y)"]
				if costToCell == nil || newCost < costToCell
				{
					costSoFar["\(cell.x),\(cell.y)"] = newCost
					// var priority: Int = newCost + manhattanDistance(cell)
					frontier.addCell(cell, priority: priority)
					cameFrom["\(cell.x),\(cell.y)"] = current
				}			
			}			
		}		
		
		// now trace our way back to find the step to take
		let myCell: MazeViewCell = delegate!.getMazeCellAtX(cellX, y: cellY)
		
		var nextStep: MazeViewCell = playerCell
		
		while cameFrom["\(nextStep.x),\(nextStep.y)"] != myCell
		{
			let tempCell: MazeViewCell = cameFrom["\(nextStep.x),\(nextStep.y)"]
		
			nextStep = delegate!.getMazeCellAtX(tempCell.x, y: tempCell.y)
		}
		
		moveTowardCell(nextStep)
	}
	
	private func moveTowardCell(cell: MazeViewCell)
	{
		if cellX < cell.x
		{
			moveInDirection(4)
		}
		else if cellX > cell.x
		{
			moveInDirection(1)
		}
		else if cellY > cell.y
		{
			moveInDirection(3)
		}
		else if cellY < cell.y
		{
			moveInDirection(0)
		}		
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
