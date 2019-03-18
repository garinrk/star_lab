//
//  PauseView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class PauseView : UIView{
    var resumeButton = UIButton(type: UIButton.ButtonType.custom)
    var quitButton = UIButton(type: UIButton.ButtonType.custom)
    var musicSlider = UISlider()
    var fxSlider = UISlider()
    
    var musicLabel = UILabel()
    var fxLabel = UILabel()
    var screenRect = UIScreen.main.bounds
    var currentScore = UILabel()
    var lifetimeScore = UILabel()
    var currentScoreLabel = UILabel()
    var lifetimeScoreLabel = UILabel()
    var pauseTitleLabel = UILabel()
    
    var titleImage = UIImage(named: "paused.png")
    var titleImageBackground = UIImageView(frame: CGRect.zero)

    var lifetimeScoreImage = UIImage(named: "lifetimescore.png")
    var lifetimeScoreImageBackground = UIImageView(frame: CGRect.zero)
    
    var currentScoreImage = UIImage(named: "currentscore.png")
    var currentScoreImageBackground = UIImageView(frame: CGRect.zero)
    
    var musicLevelImage = UIImage(named: "musiclevel.png")
    var musicLevelImageBackground = UIImageView(frame: CGRect.zero)
    
    var fxLevelImage = UIImage(named: "fxlevel.png")
    var fxLevelImageBackground = UIImageView(frame: CGRect.zero)

    var _gameManager : GameManager = GameManager.sharedInstance
    
    override func draw(_ rect: CGRect) {
        
        resumeButton.setTitle("Resume Game",for: UIControl.State())
        resumeButton.setTitleColor(UIColor.white, for: UIControl.State())
        resumeButton.layer.borderWidth = 5
        resumeButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        resumeButton.layer.cornerRadius = 5
        resumeButton.layer.borderColor = UIColor.white.cgColor
        addSubview(resumeButton)
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        
        quitButton.setTitle("Quit Game", for: UIControl.State())
        quitButton.setTitleColor(UIColor.white, for: UIControl.State())
        quitButton.layer.borderWidth = 5
        quitButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderColor = UIColor.white.cgColor
        addSubview(quitButton)
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleImageBackground.frame = CGRect(x: rect.midX, y: rect.midY, width: 200, height: 50)
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        musicLevelImageBackground.frame = CGRect(x: rect.midX, y: rect.midY, width: 200, height: 50)
        musicLevelImageBackground.image = musicLevelImage
        self.addSubview(musicLevelImageBackground)
        musicLevelImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        fxLevelImageBackground.frame = CGRect(x: rect.midX, y: rect.midY, width: 200, height: 50)
        fxLevelImageBackground.image = fxLevelImage
        self.addSubview(fxLevelImageBackground)
        fxLevelImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        currentScoreImageBackground.frame = CGRect(x: rect.midX, y: rect.midY, width: 200, height: 50)
        currentScoreImageBackground.image = currentScoreImage
        self.addSubview(currentScoreImageBackground)
        currentScoreImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        currentScore.frame = CGRect(x: rect.midX, y: rect.midY, width: 200, height: 50)
        currentScore.text = _gameManager.currentScore.description
        currentScore.textColor = UIColor.white
        currentScore.adjustsFontSizeToFitWidth = true
        currentScore.center = CGPoint(x: self.frame.maxX * 0.30,y: self.frame.maxY * 0.75)
        currentScore.textAlignment = .center
        self.addSubview(currentScore)
        currentScore.translatesAutoresizingMaskIntoConstraints = false
        
        lifetimeScoreImageBackground.frame = CGRect(x: rect.midX, y: rect.midY, width: 200, height: 50)
        lifetimeScoreImageBackground.image = lifetimeScoreImage
        self.addSubview(lifetimeScoreImageBackground)
        lifetimeScoreImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        lifetimeScore.frame = CGRect(x: rect.midX, y: rect.midY, width: 200, height: 50)
        lifetimeScore.text = _gameManager.lifetimeScore.description
        lifetimeScore.textColor = UIColor.white
        lifetimeScore.adjustsFontSizeToFitWidth = true
        lifetimeScore.center = CGPoint(x: self.frame.maxX * 0.75,y: self.frame.maxY * 0.75)
        lifetimeScore.textAlignment = .center
        self.addSubview(lifetimeScore)
        lifetimeScore.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(fxSlider)
        fxSlider.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(musicSlider)
        musicSlider.translatesAutoresizingMaskIntoConstraints = false
        
//        let views: [String:UIView] = [ "main":titleImageBackground,"musicImage":musicLevelImageBackground, "fximage":fxLevelImageBackground,"currentScoreImage":currentScoreImageBackground,"currentScore":currentScore,"quit":quitButton]
        
        let views: [String:UIView] = ["main":titleImageBackground, "lifetimeScoreImage":lifetimeScoreImageBackground, "lifetimeScore":lifetimeScore, "musicImage":musicLevelImageBackground, "fximage":fxLevelImageBackground,"currentScoreImage":currentScoreImageBackground,"currentScore":currentScore,"fxSlider":fxSlider,"musicSlider":musicSlider,"quit":quitButton,"resume":resumeButton]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[quit(<=120)]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=240)-[main(<=240)]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=80)-[musicImage(<=160)]-[musicSlider(<=160)]-(<=80)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=80)-[fximage(<=160)]-[fxSlider(<=160)]-(<=80)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[currentScoreImage(<=160)]-[lifetimeScoreImage(==currentScoreImage)]-80-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[currentScore(<=160)]-[lifetimeScore(==currentScore)]-80-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(<=240)-[resume(<=240)]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[quit(<=60,>=40)]-80-[main]-80-[musicImage]-80-[fximage(==musicImage)]-80-[currentScoreImage(<=60)][currentScore(==musicImage)]-[resume(==quit)]-80-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(<=160)-[main]-80-[musicSlider]-80-[fxSlider]-(>=80)-[lifetimeScoreImage(==currentScoreImage)][lifetimeScore(==musicImage)]-[resume(==quit)]-80-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[musicImage]-[fximage]-[currentScoreImage]-[currentScore]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleImageBackground, attribute: NSLayoutConstraint.Attribute.height, multiplier: 2.2, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: musicLevelImageBackground, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: musicLevelImageBackground, attribute: NSLayoutConstraint.Attribute.height, multiplier: 3.6, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: fxLevelImageBackground, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: fxLevelImageBackground, attribute: NSLayoutConstraint.Attribute.height, multiplier: 2.7, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: currentScoreImageBackground, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: currentScoreImageBackground, attribute: NSLayoutConstraint.Attribute.height, multiplier: 2.7, constant: 0.0))
        
//        addConstraint(NSLayoutConstraint(item: lifetimeScoreImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: lifetimeScoreImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 2.7, constant: 0.0))
        
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[main]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[scoreImage]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[main]-80-[scoreImage]-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        
    }
}
