//
//  NewGameView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class NewGameView : UIView{
    
    var newSessionLabel = UILabel()
    var diffLabel = UILabel()
    var playerNameLabel = UILabel()
    var screenRect = UIScreen.mainScreen().bounds
    
    override func drawRect(rect: CGRect) {
        
        newSessionLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        newSessionLabel.text = "New Session"
        newSessionLabel.adjustsFontSizeToFitWidth = true
        newSessionLabel.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) * 0.25)
        newSessionLabel.textAlignment = .Center
        
        diffLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        diffLabel.text = "Difficulty"
        diffLabel.adjustsFontSizeToFitWidth = true
        diffLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.70)
        diffLabel.textAlignment = .Center
        
        playerNameLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 100)
        playerNameLabel.text = "Player Name"
        playerNameLabel.adjustsFontSizeToFitWidth = true
        //        playerNameLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.70)
        playerNameLabel.textAlignment = .Center
        playerNameLabel.center.x = screenRect.midX
        playerNameLabel.center.y = screenRect.midY
        
        self.addSubview(diffLabel)
        self.addSubview(playerNameLabel)
        self.addSubview(newSessionLabel)
    }
}
