//
//  MazeView.swift
//  LabryinthMaster
//
//  Created by M on 4/9/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class MazeViewCell: UIView {
    var north: Bool = true
    var east: Bool = true
    var south: Bool = true
    var west: Bool = true
    var hasCoin: Bool = false
    
    private var coinDiameter: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        coinDiameter = bounds.width * 0.5
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        // draw background
        let background: CGRect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextFillRect(context, background)
    
        // draw walls

        CGContextSetLineWidth(context, bounds.width * 0.05)
        if north
        {
            CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        }
        else {
            CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        }
        CGContextMoveToPoint(context, bounds.minX, bounds.minY)
        CGContextAddLineToPoint(context, bounds.maxX, bounds.minY)
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        if east
        {
            CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        }
        else {
            CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        }
        CGContextMoveToPoint(context, bounds.maxX, bounds.minY)
        CGContextAddLineToPoint(context, bounds.maxX, bounds.maxY)
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        if south
        {
            CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        }
        else {
            CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        }
        CGContextMoveToPoint(context, bounds.minX, bounds.maxY)
        CGContextAddLineToPoint(context, bounds.maxX, bounds.maxY)
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        if west
        {
            CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        }
        else {
            CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        }
        CGContextMoveToPoint(context, bounds.minX, bounds.minY)
        CGContextAddLineToPoint(context, bounds.minX, bounds.maxY)
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)

        
        // draw coin
        if hasCoin {
            let halfDifferenceWidth: CGFloat = (bounds.width - coinDiameter) * 0.5
            let halfDifferenceHeight: CGFloat = (bounds.height - coinDiameter) * 0.5
            
            let x: CGFloat = bounds.minX + halfDifferenceWidth
            let y: CGFloat = bounds.minY + halfDifferenceHeight
            
            let square: CGRect = CGRect(x: x, y: y, width: coinDiameter, height: coinDiameter)
            CGContextSetFillColorWithColor(context, UIColor.orangeColor().CGColor)
            CGContextFillEllipseInRect(context, square)
        }
        
        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
}

//protocol MazeViewDelegate: class {
//    func coinCollected()
//}

class MazeView: UIView {
    
    var cells: [String: MazeViewCell] = [:]
    
    private var dimension: Int = 30
    private var cellWidth: CGFloat!
    private var cellHeight: CGFloat!
    private var originCellCenter: CGPoint!
    
//    weak var delegate: MazeViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        cellWidth = bounds.width / CGFloat(dimension)
        cellHeight = bounds.height / CGFloat(dimension)
        
        originCellCenter = CGPoint(x: (cellWidth / 2), y: (cellHeight / 2))
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    func setDimension(dimension: Int) {
        self.dimension = dimension
    }
    
    func addCellNorth(north: Bool, East east: Bool, South south: Bool, West west: Bool, AtX x: Int, Y y: Int) {
        
        let xPos: CGFloat = bounds.minX + (CGFloat(x) * cellWidth)
        let yPos: CGFloat = bounds.minY + (CGFloat(y) * cellHeight)
        
        let newCell: MazeViewCell = MazeViewCell(frame: CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight))
        
        newCell.north = north
        newCell.east = east
        newCell.south = south
        newCell.west = west
        
        cells["\(x),\(y)"] = newCell
        addSubview(newCell)
    }
    
    func detectCollisionWithRect(rect: CGRect) -> Collision
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
        
//        let sizeDiffX = cellWidth - (rect.maxX - rect.minX)
//        let touchingAnotherCellInX: Bool = remainderX > sizeDiffX

        var y = 0;
        var remainderY = rect.midY
        while remainderY > cellHeight
        {
            remainderY -= cellHeight
            y += 1
        }
        
//        let sizeDiffY = cellHeight - (rect.maxY - rect.minY)
//        let touchingAnotherCellInY: Bool = remainderY > sizeDiffY
        
        let occupyingCell: MazeViewCell? = cells["\(x),\(y)"]
        
        // coin collision
        var coin: Bool = false
        if occupyingCell != nil && occupyingCell!.hasCoin
        {
            coin = true
            occupyingCell!.hasCoin = false
//            delegate?.coinCollected()
//            setNeedsDisplay()
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
      
        return Collision(north: north, east: east, south: south, west: west, coin: coin, cellX: x, cellY: y)
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
    
    func getCellPosX(x: Int, Y y: Int) -> CGPoint
    {
        let cell: MazeViewCell! = cells["\(x),\(y)"]
        let viewIndex: Int? = subviews.indexOf(cell)
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
