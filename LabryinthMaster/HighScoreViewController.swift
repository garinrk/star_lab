//
//  HighScoreViewController.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol HighScoreViewControllerDelegate: class {
    func highScorePressedBack()
}

class HighScoreViewController : UIViewController{
    var backButton = UIButton(type: UIButtonType.Custom)
    var screenRect = UIScreen.mainScreen().bounds
    var highScore = HighScoreView()
    
    weak var delegate: HighScoreViewControllerDelegate? = nil
    var backgroundImage = UIImage(named: "space6.jpg")
    var backgroundImageView = UIImageView(frame: CGRectZero)
    
    override func viewDidLoad() {
        
        highScore.frame = UIScreen.mainScreen().bounds
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        highScore.addSubview(backgroundImageView)
        self.view.addSubview(highScore)
        
        backButton.frame = CGRectMake(50,50, 200, 50)
        backButton.center = CGPointMake(CGRectGetMidX(screenRect) * 0.40,CGRectGetMaxY(screenRect) * 0.15)
        backButton
            .addTarget(self, action: #selector(HighScoreViewController.BackButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.layer.borderWidth = 5
        backButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.view.addSubview(highScore)
        self.view.addSubview(backButton)
        
        
    }
    
    func BackButtonPressed(){
        delegate?.highScorePressedBack()
    }
    
}
