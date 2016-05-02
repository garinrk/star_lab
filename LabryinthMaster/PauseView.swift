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
    var pauseTitleLabel = UILabel()
    
    var titleImage = UIImage(named: "pause.png")
    var titleImageBackground = UIImageView(frame: CGRectZero)


    var _gameManager : GameManager = GameManager.sharedInstance
    
    override func drawRect(rect: CGRect) {
    
        
        pauseTitleLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        pauseTitleLabel.text = "Pause Menu"
        pauseTitleLabel.textColor = UIColor.blueColor()
        pauseTitleLabel.adjustsFontSizeToFitWidth = true
        pauseTitleLabel.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) * 0.25)
        pauseTitleLabel.textAlignment = .Center
        
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
        
        currentScore.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        currentScore.text = _gameManager.currentScore.description
        currentScore.adjustsFontSizeToFitWidth = true
        currentScore.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.75)
        currentScore.textAlignment = .Center
        
        lifetimeScoreLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        lifetimeScoreLabel.text = "Lifetime Score"
        lifetimeScoreLabel.adjustsFontSizeToFitWidth = true
        lifetimeScoreLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.75,CGRectGetMaxY(self.frame) * 0.70)
        lifetimeScoreLabel.textAlignment = .Center
        
        lifetimeScore.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        lifetimeScore.text = _gameManager.lifetimeScore.description
        lifetimeScore.adjustsFontSizeToFitWidth = true
        lifetimeScore.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.75,CGRectGetMaxY(self.frame) * 0.75)
        lifetimeScore.textAlignment = .Center
        
        self.addSubview(musicLabel)
        self.addSubview(fxLabel)
        self.addSubview(lifetimeScoreLabel)
        self.addSubview(currentScoreLabel)
        self.addSubview(currentScore)
        self.addSubview(lifetimeScore)
        self.addSubview(pauseTitleLabel)
        
    }
}
