//
//  MainMenuView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/17/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

/// New, load, high scores, options
class MainMenuView : UIView{
    
    var MainLabel = UILabel()
    var newGameButton = UIButton(type: UIButtonType.Custom)
    
    
    override func drawRect(rect: CGRect) {
        
        //better way to do this
        MainLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        MainLabel.text = "Pac Man's Labryinth"
        MainLabel.adjustsFontSizeToFitWidth = true
        MainLabel.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) * 0.25)
        MainLabel.textAlignment = .Center
        
        self.addSubview(MainLabel)
        
        
    }
}
