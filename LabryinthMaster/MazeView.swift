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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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

    }
    
}

class MazeView: UIView {
    
    var cells: [String: MazeViewCell] = [:]
    
    private var dimension: Int = 30
    private var cellWidth: CGFloat!
    private var cellHeight: CGFloat!
    private var originCellCenter: CGPoint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        cellWidth = bounds.width / CGFloat(dimension)
        cellHeight = bounds.height / CGFloat(dimension)
        
        originCellCenter = CGPoint(x: (cellWidth / 2), y: (cellHeight / 2))
        
        self.backgroundColor = UIColor.greenColor()
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
    
    func detectCollisionWithRect(rect: CGRect) -> Collision?
    {
        // get the cells that overlap with rect
        
        var x = 0;
        var remainderX = rect.minX
        while remainderX > cellWidth
        {
            remainderX -= cellWidth
            x += 1
        }
        // now x should be the x-coordinate of the cell that rect.minX is touching
        
        let sizeDiffX = cellWidth - (rect.maxX - rect.minX)
        let touchingAnotherCellInX: Bool = remainderX > sizeDiffX

        var y = 0;
        var remainderY = rect.minY
        while remainderY > cellHeight
        {
            remainderY -= cellHeight
            y += 1
        }
        
        let sizeDiffY = cellHeight - (rect.maxY - rect.minY)
        let touchingAnotherCellInY: Bool = remainderY > sizeDiffY
        
        let bottomCellsTouching: [MazeViewCell]!
        let topCellsTouching: [MazeViewCell]!
        let leftCellsTouching: [MazeViewCell]!
        let rightCellsTouching: [MazeViewCell]!
        
        if touchingAnotherCellInX {
            if touchingAnotherCellInY {
                bottomCellsTouching = [cells["\(x),\(y+1)"]!, cells["\(x+1),\(y+1)"]!]
                topCellsTouching = [cells["\(x),\(y)"]!, cells["\(x+1),\(y)"]!]
                leftCellsTouching = [cells["\(x),\(y)"]!, cells["\(x),\(y+1)"]!]
                rightCellsTouching = [cells["\(x+1),\(y)"]!, cells["\(x+1),\(y+1)"]!]
//                cellsTouching = [cells["\(x),\(y)"]!, cells["\(x+1),\(y)"]!, cells["\(x),\(y+1)"]!, cells["\(x+1),\(y+1)"]!]
            }
            else {
                bottomCellsTouching = [cells["\(x),\(y)"]!,cells["\(x+1),\(y)"]!]
                topCellsTouching = [cells["\(x),\(y)"]!,cells["\(x+1),\(y)"]!]
                leftCellsTouching = [cells["\(x),\(y)"]!]
                rightCellsTouching = [cells["\(x+1),\(y)"]!]
//                cellsTouching = [cells["\(x),\(y)"]!,cells["\(x+1),\(y)"]!]
            }
        }
        else {
            if touchingAnotherCellInY {
                bottomCellsTouching = [cells["\(x),\(y+1)"]!]
                topCellsTouching = [cells["\(x),\(y)"]!]
                leftCellsTouching = [cells["\(x),\(y)"]!, cells["\(x),\(y+1)"]!]
                rightCellsTouching = [cells["\(x),\(y)"]!, cells["\(x),\(y+1)"]!]
//                cellsTouching = [cells["\(x),\(y)"]!, cells["\(x),\(y+1)"]!]
            }
            else {
                
                bottomCellsTouching = [cells["\(x),\(y)"]!]
                topCellsTouching = [cells["\(x),\(y)"]!]
                leftCellsTouching = [cells["\(x),\(y)"]!]
                rightCellsTouching = [cells["\(x),\(y)"]!]
//                cellsTouching = [cells["\(x),\(y)"]!]
            }
        }
        
        // look at the (up to) four cells to determine possible collisions
        
        var north: Bool = false
        var east: Bool = false
        var south: Bool = false
        var west: Bool = false

        // check for north collision
        for cell in bottomCellsTouching
        {
            if rect.minY <= cell.frame.minY
            {
                if cell.north
                {
                    north = true
                }
                
            }
        }

        // check for east collision
        for cell in leftCellsTouching
        {
            if rect.maxX >= cell.frame.maxX
            {
                if cell.east
                {
                    east = true
                }
            }
        }
        
        // check for south collision
        for cell in topCellsTouching
        {
            if rect.maxY >= cell.frame.maxY
            {
                if cell.south
                {
                    south = true
                }
            }
        }
        
        // check for west collision
        for cell in rightCellsTouching
        {
            if rect.minX <= cell.frame.minX
            {
                if cell.west
                {
                    west = true
                }
            }
        }
        
        if north || south || east || west {
            return Collision(north: north, east: east, south: south, west: west)
        }

        return nil
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
