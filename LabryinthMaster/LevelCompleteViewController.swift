//
//  LevelCompleteViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol LevelCompleteViewControllerDelegate: class {
    func levelCompletePressedRetry()
    func levelCompletePressedExit()
}

class LevelCompleteViewController : UIViewController{
    
    var completeView = LevelCompleteView()
    var continueButton = UIButton(type: UIButtonType.Custom)
    var quitButton = UIButton(type: UIButtonType.Custom)
    var screenRect = UIScreen.mainScreen().bounds
    
    weak var delegate: LevelCompleteViewControllerDelegate? = nil
    
    var backgroundImage = UIImage(named: "blackHole.jpg")
    var backgroundImageView = UIImageView(frame: CGRectZero)
    
    override func viewDidLoad() {
        
        completeView.frame = UIScreen.mainScreen().bounds
        
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        completeView.addSubview(backgroundImageView)
        self.view.addSubview(completeView)
        
        quitButton.frame = CGRectMake(50,50, 200, 50)
        quitButton.center = CGPointMake(CGRectGetMidX(screenRect) + 200, CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.90)
        quitButton
            .addTarget(self, action: #selector(LevelCompleteViewController.QuitButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        quitButton.setTitle("Quit",forState: UIControlState.Normal)
        quitButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quitButton.backgroundColor = UIColor.grayColor()
        
        continueButton.frame = CGRectMake(50,50, 200, 50)
        continueButton.center = CGPointMake(CGRectGetMidX(screenRect) - 200,CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.90)
        continueButton
            .addTarget(self, action: #selector(LevelCompleteViewController.ContinueButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        continueButton.setTitle("Continue", forState: UIControlState.Normal)
        continueButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        continueButton.backgroundColor = UIColor.grayColor()
        
        self.completeView.addSubview(quitButton)
        self.completeView.addSubview(continueButton)
        self.view.addSubview(completeView)
        
    }
    
    func ContinueButtonPressed(){
        delegate?.levelCompletePressedRetry()
    }
    
    func QuitButtonPressed(){
        delegate?.levelCompletePressedExit()
    }
    
}
