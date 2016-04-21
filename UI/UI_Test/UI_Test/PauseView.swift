//
//  PauseView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class PauseView : UIView{
    var musicLabel = UILabel()
    var fxLabel = UILabel()
    var screenRect = UIScreen.mainScreen().bounds
    var currentScore = UILabel()
    var lifetimeScore = UILabel()
    var currentScoreLabel = UILabel()
    var lifetimeScoreLabel = UILabel()
    
    override func drawRect(rect: CGRect) {
        
        musicLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        musicLabel.text = "Music Level"
        musicLabel.adjustsFontSizeToFitWidth = true
        musicLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.55)
        musicLabel.textAlignment = .Center
        
        fxLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        fxLabel.text = "Effects Level"
        fxLabel.adjustsFontSizeToFitWidth = true
        fxLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.60)
        fxLabel.textAlignment = .Center
        
        currentScoreLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        currentScoreLabel.text = "Current Score"
        currentScoreLabel.adjustsFontSizeToFitWidth = true
        currentScoreLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.70)
        currentScoreLabel.textAlignment = .Center
        
        lifetimeScoreLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        lifetimeScoreLabel.text = "Lifetime Score"
        lifetimeScoreLabel.adjustsFontSizeToFitWidth = true
        lifetimeScoreLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.75,CGRectGetMaxY(self.frame) * 0.70)
        lifetimeScoreLabel.textAlignment = .Center
        
        self.addSubview(musicLabel)
        self.addSubview(fxLabel)
        self.addSubview(lifetimeScoreLabel)
        self.addSubview(currentScoreLabel)
        
    }
}
