//
//  MazeView.swift
//  LabryinthMaster
//
//  Created by M on 4/9/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class MazeViewCell: UIView {
    private var north: Bool = true
    private var east: Bool = true
    private var south: Bool = true
    private var west: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

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
            CGContextDrawPath(context, kCGPathStroke)
//                CGPathDrawingMode.Stroke
        }
        if east
        {
            CGContextMoveToPoint(context, bounds.maxX, bounds.minY)
            CGContextAddLineToPoint(context, bounds.maxX, bounds.maxY)
            CGContextDrawPath(context, kCGPathStroke)
            //                CGPathDrawingMode.Stroke
        }
        if south
        {
            CGContextMoveToPoint(context, bounds.minX, bounds.maxY)
            CGContextAddLineToPoint(context, bounds.maxX, bounds.maxY)
            CGContextDrawPath(context, kCGPathStroke)
            //                CGPathDrawingMode.Stroke
        }
        if west
        {
            CGContextMoveToPoint(context, bounds.minX, bounds.minY)
            CGContextAddLineToPoint(context, bounds.minX, bounds.maxY)
            CGContextDrawPath(context, kCGPathStroke)
            //                CGPathDrawingMode.Stroke
        }
        
    }
    
//    func setClear(clear: Bool) {
//        self.clear = clear
//    }
    
}

class MazeView: UIView {
    
    var cells: [MazeViewCell] = []
    private var dimension: Int = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        let widthPortion: CGFloat = bounds.width / CGFloat(dimension)
        let heightPortion: CGFloat = bounds.height / CGFloat(dimension)
        let xPos: CGFloat = bounds.minX + (CGFloat(x) * widthPortion)
        let yPos: CGFloat = bounds.minY + (CGFloat(y) * heightPortion)
        
        let newCell: MazeViewCell = MazeViewCell(frame: CGRect(x: xPos, y: yPos, width: widthPortion, height: heightPortion))
        
        newCell.north = north
        newCell.east = east
        newCell.south = south
        newCell.west = west
        cells.append(newCell)
        addSubview(newCell)
    }
}
