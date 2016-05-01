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
    
    override func viewDidLoad() {
        
        highScore.frame = UIScreen.mainScreen().bounds
        highScore.backgroundColor = UIColor.brownColor()
        
        backButton.frame = CGRectMake(50,50, 200, 50)
        backButton.center = CGPointMake(CGRectGetMidX(screenRect) * 0.40,CGRectGetMaxY(screenRect) * 0.15)
        backButton
            .addTarget(self, action: #selector(HighScoreViewController.BackButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.backgroundColor = UIColor.grayColor()
        
        self.view.addSubview(highScore)
        self.view.addSubview(backButton)
        
        
    }
    
    func BackButtonPressed(){
        delegate?.highScorePressedBack()
    }
    
}
