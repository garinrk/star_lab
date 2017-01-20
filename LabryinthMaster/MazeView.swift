//
//  MazeView.swift
//  LabryinthMaster
//
//  Created by M on 4/9/16.
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

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MazeViewCell: UIView {
    var north: Bool = true
    var east: Bool = true
    var south: Bool = true
    var west: Bool = true
    var hasCoin: Bool = false
    var goal: Bool = false
    
    var label: Int = 0
    
    var x: Int = 0
    var y: Int = 0
    
    fileprivate var coinDiameter: CGFloat = 0
    fileprivate var goalWidth: CGFloat = 0
    
    var coinImage = UIImage(named: "coin.png")
    var goalImage = UIImage(named: "goal.png")
    var backgroundImageView = UIImageView(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        coinDiameter = bounds.width * 0.5
        goalWidth = bounds.width * 0.85
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // get rid of previous views
        for sview in subviews {
            sview.removeFromSuperview()
        }
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        // draw background
        let background: CGRect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
//        let semiTransparentBackground: UIColor = UIColor(white: 1, alpha: 0.5)
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(background)
    
        // draw walls

        context?.setLineWidth(bounds.width * 0.05)
        if north
        {
            context?.setStrokeColor(UIColor.red.cgColor)
            context?.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            context?.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
        else {
            context?.setStrokeColor(UIColor.white.cgColor)
            context?.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            context?.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }

        if east
        {
            context?.setStrokeColor(UIColor.red.cgColor)
            context?.move(to: CGPoint(x: bounds.maxX, y: bounds.minY))
            context?.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
        else {
            context?.setStrokeColor(UIColor.white.cgColor)
            context?.move(to: CGPoint(x: bounds.maxX, y: bounds.minY))
            context?.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }

        if south
        {
            context?.setStrokeColor(UIColor.red.cgColor)
            context?.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            context?.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
        else {
            context?.setStrokeColor(UIColor.white.cgColor)
            context?.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            context?.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }

        if west
        {
            context?.setStrokeColor(UIColor.red.cgColor)
            context?.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            context?.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
        else {
            context?.setStrokeColor(UIColor.white.cgColor)
            context?.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            context?.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }


        
        // draw coin
        if hasCoin {
            
            //draw a coin
            backgroundImageView.frame = bounds
            backgroundImageView.image = coinImage
            backgroundImageView.tag = 2020
            self.addSubview(backgroundImageView)
//            let halfDifferenceWidth: CGFloat = (bounds.width - coinDiameter) * 0.5
//            let halfDifferenceHeight: CGFloat = (bounds.height - coinDiameter) * 0.5
//            
//            let x: CGFloat = bounds.minX + halfDifferenceWidth
//            let y: CGFloat = bounds.minY + halfDifferenceHeight
//            
//            let square: CGRect = CGRect(x: x, y: y, width: coinDiameter, height: coinDiameter)
//            CGContextSetFillColorWithColor(context, UIColor.orangeColor().CGColor)
//            CGContextFillEllipseInRect(context, square)
        }
        
        // draw exit
        if goal {
            backgroundImageView.frame = bounds
            backgroundImageView.image = goalImage
            backgroundImageView.tag = 2112
            self.addSubview(backgroundImageView)
//            let halfDifferenceWidth: CGFloat = (bounds.width - goalWidth) * 0.5
//            let halfDifferenceHeight: CGFloat = (bounds.height - goalWidth) * 0.5
//            
//            let x: CGFloat = bounds.minX + halfDifferenceWidth
//            let y: CGFloat = bounds.minY + halfDifferenceHeight
//            
//            let square: CGRect = CGRect(x: x, y: y, width: goalWidth, height: goalWidth)
//            CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
//            CGContextFillRect(context, square)

        }
//        else{
//            for sview in self.subviews{
//                if sview.tag == 2020{
////                    sview.removeFromSuperview()
//                }
//            }
//        }
        
//        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
}

//protocol MazeViewDelegate: class {
//    func coinCollected()
//}

class MazeView: UIView {
    
    var cells: [String: MazeViewCell] = [:]
    
    fileprivate var dimension: Int = 30
    fileprivate var cellWidth: CGFloat!
    fileprivate var cellHeight: CGFloat!
    fileprivate var originCellCenter: CGPoint!
    
    fileprivate var cellLabeller: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        cellWidth = bounds.width / CGFloat(dimension)
        cellHeight = bounds.height / CGFloat(dimension)
        
        originCellCenter = CGPoint(x: (cellWidth / 2), y: (cellHeight / 2))
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func setDimension(_ dimension: Int) {
        self.dimension = dimension
    }
    
    func addCellNorth(_ north: Bool, East east: Bool, South south: Bool, West west: Bool, AtX x: Int, Y y: Int) {
        
        let xPos: CGFloat = bounds.minX + (CGFloat(x) * cellWidth)
        let yPos: CGFloat = bounds.minY + (CGFloat(y) * cellHeight)
        
        let newCell: MazeViewCell = MazeViewCell(frame: CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight))
        
        newCell.north = north
        newCell.east = east
        newCell.south = south
        newCell.west = west
        newCell.x = x
        newCell.y = y
        newCell.label = cellLabeller
        cellLabeller += 1
        
        cells["\(x),\(y)"] = newCell
        newCell.tag = newCell.label
        addSubview(newCell)
    }
    
    func detectCollisionWithRect(_ rect: CGRect) -> Collision
    {
        // get the cell that rect's center is in
        
        var x = 0;
        var remainderX = rect.midX
        
        while remainderX > cellWidth
        {
            remainderX -= cellWidth
            x += 1
        }
        // now x should be the x-coordinate of the cell that rect.midX is touching
        
        var y = 0;
        var remainderY = rect.midY
        while remainderY > cellHeight
        {
            remainderY -= cellHeight
            y += 1
        }
        
        let occupyingCell: MazeViewCell? = cells["\(x),\(y)"]
        
        // coin collision
        var coin: Bool = false
        if occupyingCell != nil && occupyingCell!.hasCoin
        {
            coin = true
        }
        
        // goal collision
        var goal: Bool = false
        if occupyingCell != nil && occupyingCell!.goal
        {
            goal = true
//            //remove the goal view
//            for sview in (occupyingCell?.subviews)!{
//                if sview.tag == 2112{
//                    sview.removeFromSuperview()
//                }
//            }
        }
        
        // check to see if object is centered in cell
        var centeredX: Bool = false
        var centeredY: Bool = false
        let leewayAmt: CGFloat = 0.1
        
		if occupyingCell != nil
		{
            let xDiff: CGFloat = abs(occupyingCell!.frame.midX - rect.midX)
            let yDiff: CGFloat = abs(occupyingCell!.frame.midY - rect.midY)
            if xDiff < leewayAmt {
                centeredX = true
            }
            if yDiff < leewayAmt {
                centeredY = true
            }
		}
		
		
        // look at the cell to determine possible collisions
        
        var north: Bool = false
        var east: Bool = false
        var south: Bool = false
        var west: Bool = false

        // check for north collision
        if occupyingCell != nil && rect.minY <= occupyingCell!.frame.minY
        {
            if occupyingCell!.north
            {
                north = true
            }
            
        }

        // check for east collision
        
        if occupyingCell != nil && rect.maxX >= occupyingCell!.frame.maxX
        {
            if occupyingCell!.east
            {
                east = true
            }
        }
        
        
        // check for south collision
        if occupyingCell != nil && rect.maxY >= occupyingCell!.frame.maxY
        {
            if occupyingCell!.south
            {
                south = true
            }
        }
      
        // check for west collision
       
        if occupyingCell != nil && rect.minX <= occupyingCell!.frame.minX
        {
            if occupyingCell!.west
            {
                west = true
            }
        }
        
        var collisionTag: Int = 0
        if occupyingCell != nil {
            collisionTag = occupyingCell!.label
        }
      
      
        return Collision(north: north, east: east, south: south, west: west, coin: coin, cellX: x, cellY: y, centeredX: centeredX, centeredY: centeredY, collisionTag: collisionTag, goal: goal)
    }
    
    func placeRandomCoin() {
        
        var tryAgain: Bool = true
        
        while tryAgain {
            let x = Int(arc4random_uniform(UInt32(dimension)))
            let y = Int(arc4random_uniform(UInt32(dimension)))
            
            let cell: MazeViewCell = cells["\(x),\(y)"]!
            
            if cell.hasCoin == false {
                cell.hasCoin = true
                tryAgain = false
            }
        }
    }
    
    func placeGoalX(_ x: Int, Y y: Int) {
        cells["\(x),\(y)"]?.goal = true
    }
    
    func getCellPosX(_ x: Int, Y y: Int) -> CGPoint
    {
        let cell: MazeViewCell! = cells["\(x),\(y)"]
        let viewIndex: Int? = subviews.index(of: cell)
        if viewIndex != nil
        {
            let view: UIView = subviews[viewIndex!]
            return view.frame.origin
        }
        
        let result: CGPoint = CGPoint(x: (cell.bounds.maxX - cell.bounds.minX), y: (cell.bounds.maxY - cell.bounds.minY))
        return result
    }
    
    func getCellSize() -> CGSize
    {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
