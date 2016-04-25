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
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        if north
        {
            CGContextMoveToPoint(context, bounds.minX, bounds.minY)
            CGContextAddLineToPoint(context, bounds.maxX, bounds.minY)
            CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        }
        if east
        {
            CGContextMoveToPoint(context, bounds.maxX, bounds.minY)
            CGContextAddLineToPoint(context, bounds.maxX, bounds.maxY)
            CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        }
        if south
        {
            CGContextMoveToPoint(context, bounds.minX, bounds.maxY)
            CGContextAddLineToPoint(context, bounds.maxX, bounds.maxY)
            CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        }
        if west
        {
            CGContextMoveToPoint(context, bounds.minX, bounds.minY)
            CGContextAddLineToPoint(context, bounds.minX, bounds.maxY)
            CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        }
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
        
        self.backgroundColor = UIColor.whiteColor()
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
        
        var cellsTouching: [String] = []
        
        if touchingAnotherCellInX {
            if touchingAnotherCellInY {
                cellsTouching = ["\(x),\(y)", "\(x+1),\(y)", "\(x),\(y+1)", "\(x+1),\(y+1)"]
            }
            else {
                cellsTouching = ["\(x),\(y)", "\(x+1),\(y)"]
            }
        }
        else {
            if touchingAnotherCellInY {
                cellsTouching = ["\(x),\(y)", "\(x),\(y+1)"]
            }
            else {
                cellsTouching = ["\(x),\(y)"]
            }
        }
        
        // look at the (up to) four cells to determine possible collisions
        
        for cellString in cellsTouching
        {
            let cell = cells[cellString]
            
            if cell != nil
            {
                if rect.minX <= cell!.frame.minX
                {
                    if cell!.west
                    {
                        return Collision(north: false, east: false, south: false, west: true)
                    }
                }
                
                if rect.maxX >= cell!.frame.maxX
                {
                    if cell!.east
                    {
                        return Collision(north: false, east: true, south: false, west: false)
                    }
                }
                
                if rect.minY <= cell!.frame.minY
                {
                    if cell!.north
                    {
                        return Collision(north: true, east: false, south: false, west: false)
                    }
                    
                }
                
                if rect.maxY >= cell!.frame.maxY
                {
                    if cell!.south
                    {
                        return Collision(north: false, east: false, south: true, west: false)
                    }
                }
            }
        }
        return nil
    }
    
//    func detectCenteredInCell(rect: CGRect) -> Bool
//    {
//        // find center of rect
//        let center: CGPoint = CGPoint(x: (rect.maxX - rect.minX), y: (rect.maxY - rect.minY))
//        
//        let errorMargin: CGFloat = 0.1
//        
//        if (center.x % originCellCenter.x) <= errorMargin && (center.y % originCellCenter.y) <= errorMargin
//        {
//            return true
//        }
//                
//        return false
//    }
    
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
}
