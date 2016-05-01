//
//  MainMenuViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/18/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class MainMenuViewController : UIViewController{
    
    var mmview = MainMenuView()
    
    var ngvc : NewGameViewController?
    var ovc : OptionsViewController?
    var hsvc : HighScoreViewController?
    var newGameButton = UIButton(type: UIButtonType.Custom)
    var loadGameButton = UIButton(type: UIButtonType.Custom)
    var optionsButton = UIButton(type: UIButtonType.Custom)
    var scoresButton = UIButton(type: UIButtonType.Custom)
    var screenRect : CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        mmview.frame = UIScreen.mainScreen().bounds
        mmview.backgroundColor = UIColor.brownColor()
        //hide back button and top bar
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.hidden = true
        
        newGameButton.frame = CGRectMake(50,50, 200, 50)
        newGameButton.center = CGPointMake(CGRectGetMidX(screenRect) - 200,CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.75)
        newGameButton
            .addTarget(self, action: #selector(MainMenuViewController.NewGameButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        newGameButton.setTitle("New Game", forState: UIControlState.Normal)
        newGameButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        newGameButton.backgroundColor = UIColor.grayColor()
        
        
        loadGameButton.frame = CGRectMake(50,50, 200, 50)
        loadGameButton.center = CGPointMake(CGRectGetMidX(screenRect) + 200, CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.75)
        loadGameButton
            .addTarget(self, action: #selector(MainMenuViewController.LoadGameButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        loadGameButton.setTitle("Load Game",forState: UIControlState.Normal)
        loadGameButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        loadGameButton.backgroundColor = UIColor.grayColor()
        
        optionsButton.frame = CGRectMake(50,50, 200, 50)
        optionsButton.center = CGPointMake(CGRectGetMidX(screenRect) + 200, CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.90)
        optionsButton
            .addTarget(self, action: #selector(MainMenuViewController.OptionsButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        optionsButton.setTitle("Options",forState: UIControlState.Normal)
        optionsButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        optionsButton.backgroundColor = UIColor.grayColor()
        
        scoresButton.frame = CGRectMake(50,50, 200, 50)
        scoresButton.center = CGPointMake(CGRectGetMidX(screenRect) - 200,CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.90)
        scoresButton
            .addTarget(self, action: #selector(MainMenuViewController.ScoresButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        scoresButton.setTitle("High Scores", forState: UIControlState.Normal)
        scoresButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        scoresButton.backgroundColor = UIColor.grayColor()
        
        self.mmview.addSubview(newGameButton)
        self.mmview.addSubview(loadGameButton)
        self.mmview.addSubview(optionsButton)
        self.mmview.addSubview(scoresButton)
        
        self.view.addSubview(mmview)
    }
    
    func NewGameButtonPressed(){
        ngvc = NewGameViewController()
        
        print("Presenting New Game")
        navigationController?.pushViewController(ngvc!, animated: true)
//        self.navigationController?.pushViewController(ngvc!, animated: true)
        
    }
    
    func LoadGameButtonPressed(){
        print("Load game")
    }
    
    func OptionsButtonPressed(){
        ovc = OptionsViewController()
        
        print("Presenting Options")
        self.navigationController?.pushViewController(ovc!, animated: true)
    }
    
    func ScoresButtonPressed(){
        hsvc = HighScoreViewController()
        
        print("Presenting Scores")
        self.navigationController?.pushViewController(hsvc!, animated: true)
        
        
    }
}
