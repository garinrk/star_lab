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
    
    weak var delegate: GameOverViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        
        gameOverView.frame = UIScreen.mainScreen().bounds
        gameOverView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        quitButton.frame = CGRectMake(50,50, 200, 50)
        quitButton.center = CGPointMake(CGRectGetMidX(screenRect) + 200, CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.90)
        quitButton
            .addTarget(self, action: #selector(GameOverViewController.QuitButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        quitButton.setTitle("Quit",forState: UIControlState.Normal)
        quitButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quitButton.backgroundColor = UIColor.grayColor()
        
        tryAgainButton.frame = CGRectMake(50,50, 200, 50)
        tryAgainButton.center = CGPointMake(CGRectGetMidX(screenRect) - 200,CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.90)
        tryAgainButton
            .addTarget(self, action: #selector(GameOverViewController.TryAgainPressed), forControlEvents: UIControlEvents.TouchUpInside)
        tryAgainButton.setTitle("Try Again", forState: UIControlState.Normal)
        tryAgainButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tryAgainButton.backgroundColor = UIColor.grayColor()
        
        self.gameOverView.addSubview(quitButton)
        self.gameOverView.addSubview(tryAgainButton)
        self.view.addSubview(gameOverView)
        
    }
    
    func TryAgainPressed(){
        delegate?.gameOverPressedRetry()
    }
    
    func QuitButtonPressed(){
        delegate?.gameOverPressedExit()
    }
    
}
