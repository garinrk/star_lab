//
//  PauseView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class PauseView : UIView{
    var resumeButton = UIButton(type: UIButtonType.Custom)
    var quitButton = UIButton(type: UIButtonType.Custom)
    var musicSlider : UISlider?
    var fxSlider : UISlider?
    
    var musicLabel = UILabel()
    var fxLabel = UILabel()
    var screenRect = UIScreen.mainScreen().bounds
    var currentScore = UILabel()
    var lifetimeScore = UILabel()
    var currentScoreLabel = UILabel()
    var lifetimeScoreLabel = UILabel()
    var pauseTitleLabel = UILabel()
    
    var titleImage = UIImage(named: "paused.png")
    var titleImageBackground = UIImageView(frame: CGRectZero)

    var lifetimeScoreImage = UIImage(named: "lifetimescore.png")
    var lifetimeScoreImageBackground = UIImageView(frame: CGRectZero)
    
    var currentScoreImage = UIImage(named: "currentscore.png")
    var currentScoreImageBackground = UIImageView(frame: CGRectZero)
    
    var musicLevelImage = UIImage(named: "musiclevel.png")
    var musicLevelImageBackground = UIImageView(frame: CGRectZero)
    
    var fxLevelImage = UIImage(named: "fxlevel.png")
    var fxLevelImageBackground = UIImageView(frame: CGRectZero)

    var _gameManager : GameManager = GameManager.sharedInstance
    
    override func drawRect(rect: CGRect) {
        
        resumeButton.setTitle("Resume Game",forState: UIControlState.Normal)
        resumeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        resumeButton.layer.borderWidth = 5
        resumeButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        resumeButton.layer.cornerRadius = 5
        resumeButton.layer.borderColor = UIColor.whiteColor().CGColor
        addSubview(resumeButton)
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        
        quitButton.setTitle("Quit Game", forState: UIControlState.Normal)
        quitButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quitButton.layer.borderWidth = 5
        quitButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderColor = UIColor.whiteColor().CGColor
        addSubview(quitButton)
        
        titleImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        
        musicLevelImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        musicLevelImageBackground.image = musicLevelImage
        self.addSubview(musicLevelImageBackground)
        
        fxLevelImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        fxLevelImageBackground.image = fxLevelImage
        self.addSubview(fxLevelImageBackground)
        
        currentScoreImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        currentScoreImageBackground.image = currentScoreImage
        self.addSubview(currentScoreImageBackground)
        
        currentScore.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        currentScore.text = _gameManager.currentScore.description
        currentScore.adjustsFontSizeToFitWidth = true
        currentScore.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.75)
        currentScore.textAlignment = .Center
        
        lifetimeScoreImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        lifetimeScoreImageBackground.image = lifetimeScoreImage
        self.addSubview(lifetimeScoreImageBackground)
        
        lifetimeScore.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        lifetimeScore.text = _gameManager.lifetimeScore.description
        lifetimeScore.adjustsFontSizeToFitWidth = true
        lifetimeScore.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.75,CGRectGetMaxY(self.frame) * 0.75)
        lifetimeScore.textAlignment = .Center
        
        self.addSubview(musicSlider!)
        self.addSubview(fxSlider!)
        
        self.addSubview(currentScore)
        self.addSubview(lifetimeScore)
        
    }
}
