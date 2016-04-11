//
//  MazeView.swift
//  LabryinthMaster
//
//  Created by M on 4/9/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class MazeViewCell: UIView {
    private var clear: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        let background: CGRect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
        
        if clear
        {
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        }
        else
        {
            CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        }
        CGContextFillRect(context, background)
    }
    
    func setClear(clear: Bool) {
        self.clear = clear
    }
    
}

class MazeView: UIView {
    
    var cells: [MazeViewCell] = []
    private var dimension: Int = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    func setDimension(dimension: Int) {
        self.dimension = dimension
    }
    
    func addCell(clear: Bool, AtX x: Int, Y y: Int) {
        
        let widthPortion: CGFloat = bounds.width / CGFloat(dimension)
        let heightPortion: CGFloat = bounds.height / CGFloat(dimension)
        let xPos: CGFloat = bounds.minX + (CGFloat(x) * widthPortion)
        let yPos: CGFloat = bounds.minY + (CGFloat(y) * heightPortion)
        
        let newCell: MazeViewCell = MazeViewCell(frame: CGRect(x: xPos, y: yPos, width: widthPortion, height: heightPortion))
        
        newCell.setClear(clear)
        cells.append(newCell)
        addSubview(newCell)
    }
}
