//
//  GyroView.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class PlayerView : UIView{
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    private let moveSpeed: CGFloat = 40.0
    
    ////////////////////////////////////////
    
    private var xPos: CGFloat
    private var yPos: CGFloat
    private var playerRadius: CGFloat!

    override init(frame: CGRect) {
        
        xPos = 0
        yPos = 0
        
        super.init(frame: frame)
        
        playerRadius = frame.width * 0.025
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        // draw circle
        let x: CGFloat = bounds.minX + xPos
        let y: CGFloat = bounds.minY + yPos
        
        let square: CGRect = CGRect(x: x, y: y, width: playerRadius, height: playerRadius)
        CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextFillEllipseInRect(context, square)
        
        // clear the background
        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }

    func moveX(xMagnitude: CGFloat, Y yMagnitude: CGFloat) {
        xPos += xMagnitude * moveSpeed
        yPos += yMagnitude * moveSpeed
//        setNeedsDisplay()
    }
    
    func update()
    {
        setNeedsDisplay()
    }
}
