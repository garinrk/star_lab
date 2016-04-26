//
//  CoinView.swift
//  LabryinthMaster
//
//  Created by M on 4/25/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol CoinViewDelegate: class {
    func getMazeDimension() -> Int
    func getMazeCellPosX(x: Int, Y y: Int) -> CGPoint
    func getMazeCellSize() -> CGSize
}

class CoinView: UIView {
    
    private var xPos: CGFloat
    private var yPos: CGFloat
    
    private var coinDiameter: CGFloat!
    
    weak var delegate: CoinViewDelegate? = nil
    
    private var collided: Bool = false
    
    override init(frame: CGRect) {
        xPos = 0
        yPos = 0
        
        super.init(frame: frame)
        
        coinDiameter = bounds.width * 0.015
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
        
        let square: CGRect = CGRect(x: x, y: y, width: coinDiameter, height: coinDiameter)
        CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
        CGContextFillEllipseInRect(context, square)
        
        // clear the background
        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
    func start()
    {
        if delegate == nil {
            return
        }
        
        randomizeLocation()
    }
    
    
    func randomizeLocation()
    {
        let dimension: Int = delegate!.getMazeDimension()
        let cellSize: CGSize = delegate!.getMazeCellSize()
        
        let cellX = Int(arc4random_uniform(UInt32(dimension)))
        let cellY = Int(arc4random_uniform(UInt32(dimension)))
        
        let cellOrigin: CGPoint = delegate!.getMazeCellPosX(cellX, Y: cellY)
        
        let halfDifferenceWidth: CGFloat = (cellSize.width - coinDiameter) * 0.5
        let halfDifferenceHeight: CGFloat = (cellSize.height - coinDiameter) * 0.5
        
        xPos = cellOrigin.x + halfDifferenceWidth
        yPos = cellOrigin.y + halfDifferenceHeight
        
    }
    
    func update()
    {
        setNeedsDisplay()
    }
}
