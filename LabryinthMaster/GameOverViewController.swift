//
//  LevelCompleteViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol GameOverViewControllerDelegate: class {
    func gameOverPressedRetry()
    func gameOverPressedExit()
}

class GameOverViewController : UIViewController{
    
    var gameOverView = GameOverView()
    var tryAgainButton = UIButton(type: UIButtonType.Custom)
    var quitButton = UIButton(type: UIButtonType.Custom)
    var screenRect = UIScreen.mainScreen().bounds
    var lifetimeScore: Int = 0
    
    weak var delegate: GameOverViewControllerDelegate? = nil
    
    var backgroundImage = UIImage(named: "space5.jpg")
    var backgroundImageView = UIImageView(frame: CGRectZero)
    
    override func viewDidLoad() {
        
        gameOverView.lifetimeScoreAmt = lifetimeScore
        gameOverView.frame = UIScreen.mainScreen().bounds
        
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(gameOverView)
        
        
        
        quitButton.frame = CGRectMake(50,50, 200, 50)
        quitButton.center = CGPointMake(CGRectGetMidX(screenRect) + 200, CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.90)
        quitButton
            .addTarget(self, action: #selector(GameOverViewController.QuitButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        quitButton.setTitle("Quit",forState: UIControlState.Normal)
        quitButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quitButton.layer.borderWidth = 5
        quitButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        tryAgainButton.frame = CGRectMake(50,50, 200, 50)
        tryAgainButton.center = CGPointMake(CGRectGetMidX(screenRect) - 200,CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.90)
        tryAgainButton
            .addTarget(self, action: #selector(GameOverViewController.TryAgainPressed), forControlEvents: UIControlEvents.TouchUpInside)
        tryAgainButton.setTitle("Try Again", forState: UIControlState.Normal)
        tryAgainButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tryAgainButton.layer.borderWidth = 5
        tryAgainButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        tryAgainButton.layer.cornerRadius = 5
        tryAgainButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.gameOverView.addSubview(quitButton)
        self.gameOverView.addSubview(tryAgainButton)
        
    }
    
    func TryAgainPressed(){
        delegate?.gameOverPressedRetry()
    }
    
    func QuitButtonPressed(){
        delegate?.gameOverPressedExit()
    }
    
}
