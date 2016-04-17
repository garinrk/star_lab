//
//  EnemyView.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/13/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol EnemyViewDelegate: class {
    func detectCollisionFromEnemy(square: CGRect)
}

class EnemyView: UIView {
    
    private var _xPos: Float = 0
    var xPos: Float {
        get {
            return _xPos
        }
        set {
            _xPos = newValue
            setNeedsDisplay()
        }
    }
    
    private var _yPos: Float = 0
    var yPos: Float {
        get {
            return _yPos
        }
        set {
            _yPos = newValue
            setNeedsDisplay()
        }
    }
    
    weak var delegate: EnemyViewDelegate? = nil
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        // draw square
        
        let widthPortion: CGFloat = bounds.width / CGFloat(30) * 0.55
        let heightPortion: CGFloat = bounds.height / CGFloat(30) * 0.55
        let x: CGFloat = bounds.minX + (CGFloat(xPos) * widthPortion)
        let y: CGFloat = bounds.minY + (CGFloat(yPos) * heightPortion)

        let square: CGRect = CGRect(x: x, y: y, width: widthPortion, height: heightPortion)
        CGContextSetFillColorWithColor(context, UIColor.purpleColor().CGColor)
        CGContextFillRect(context, square)
        
        delegate?.detectCollisionFromEnemy(square)
        
        // clear the background
        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }
}
