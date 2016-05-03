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
    var musicSlider = UISlider()
    var fxSlider = UISlider()
    
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
//        addSubview(resumeButton)
//        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        
        quitButton.setTitle("Quit Game", forState: UIControlState.Normal)
        quitButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quitButton.layer.borderWidth = 5
        quitButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderColor = UIColor.whiteColor().CGColor
        addSubview(quitButton)
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        musicLevelImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        musicLevelImageBackground.image = musicLevelImage
        self.addSubview(musicLevelImageBackground)
        musicLevelImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        fxLevelImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        fxLevelImageBackground.image = fxLevelImage
        self.addSubview(fxLevelImageBackground)
        fxLevelImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        currentScoreImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        currentScoreImageBackground.image = currentScoreImage
        self.addSubview(currentScoreImageBackground)
        currentScoreImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        currentScore.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        currentScore.text = _gameManager.currentScore.description
        currentScore.textColor = UIColor.whiteColor()
        currentScore.adjustsFontSizeToFitWidth = true
        currentScore.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.75)
        currentScore.textAlignment = .Center
        self.addSubview(currentScore)
        currentScore.translatesAutoresizingMaskIntoConstraints = false
        
        lifetimeScoreImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        lifetimeScoreImageBackground.image = lifetimeScoreImage
//        self.addSubview(lifetimeScoreImageBackground)
//        lifetimeScoreImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        lifetimeScore.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        lifetimeScore.text = _gameManager.lifetimeScore.description
        lifetimeScore.textColor = UIColor.whiteColor()
        lifetimeScore.adjustsFontSizeToFitWidth = true
        lifetimeScore.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.75,CGRectGetMaxY(self.frame) * 0.75)
        lifetimeScore.textAlignment = .Center
//        self.addSubview(lifetimeScore)
//        lifetimeScore.translatesAutoresizingMaskIntoConstraints = false
        
        
//        self.addSubview(fxSlider)
//        fxSlider.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(musicSlider)
//        musicSlider.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:UIView] = [ "main":titleImageBackground,"musicImage":musicLevelImageBackground, "fximage":fxLevelImageBackground,"currentScoreImage":currentScoreImageBackground,"currentScore":currentScore,"quit":quitButton]
        
//let views: [String:UIView] = ["main":titleImageBackground, "lifetimeScoreImage":lifetimeScoreImageBackground, "lifetimeScore":lifetimeScore, "musicImage":musicLevelImageBackground, "fximage":fxLevelImageBackground,"currentScoreImage":currentScoreImageBackground,"currentScore":currentScore,"fxSlider":fxSlider,"musicSlider":musicSlider,"quit":quitButton,"resume":resumeButton]
        
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[quit]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-160-[main]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[musicImage]-80-[musicSlider]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[fximage]-80-[fxSlider]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[currentScoreImage]-80-[lifetimeScoreImage]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[currentScore]-80-[lifetimeScore]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[resume]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[quit(<=120)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-240-[main(<=240)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[musicImage(<=160)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[fximage(<=160)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[currentScoreImage(<=160)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[currentScore(<=120)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[resume]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[quit(<=60)]-80-[main]-80-[musicImage]-40-[fximage]-80-[currentScoreImage(<=60)]-[currentScore]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[musicImage]-[fximage]-[currentScoreImage]-[currentScore]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 2.2, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: musicLevelImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: musicLevelImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 3.6, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: fxLevelImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: fxLevelImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 2.7, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: currentScoreImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: currentScoreImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 2.7, constant: 0.0))
        
//        addConstraint(NSLayoutConstraint(item: lifetimeScoreImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: lifetimeScoreImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 2.7, constant: 0.0))
        
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[main]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[scoreImage]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[main]-80-[scoreImage]-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        
        
        
        
        
    }
}
