//
//  LevelCompleteView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class LevelCompleteView : UIView{
    var completeLabel = UILabel()
    var scoreLabel = UILabel()
    var lifetimeScore = UILabel()
    var screenRect = UIScreen.mainScreen().bounds
    

    
    override func drawRect(rect: CGRect) {

        completeLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 400, 100)
        completeLabel.text = "Level Complete"
        completeLabel.textColor = UIColor.greenColor()
        completeLabel.adjustsFontSizeToFitWidth = true
        completeLabel.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) * 0.25)
        completeLabel.textAlignment = .Center
        
        scoreLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 100)
        scoreLabel.text = "Lifetime Score"
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.textAlignment = .Center
        scoreLabel.center.x = screenRect.midX
        scoreLabel.center.y = screenRect.midY
        
        lifetimeScore.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect) + 30, 200, 100)
        lifetimeScore.text = "SCORE HERE"
        lifetimeScore.adjustsFontSizeToFitWidth = true
        lifetimeScore.textAlignment = .Center
        lifetimeScore.center.x = screenRect.midX
        //        lifetimeScore.center.y = screenRect.midY
        
        self.addSubview(completeLabel)
        self.addSubview(scoreLabel)
        self.addSubview(lifetimeScore)
    }
}
