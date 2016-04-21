//
//  NewGameViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class NewGameViewController : UIViewController{
    
    var screenRect = UIScreen.mainScreen().bounds
    var diff : GameDifficulty? = .NONE
    var backButton = UIButton(type: UIButtonType.Custom)
    var easyButton = UIButton(type: UIButtonType.Custom)
    var hardButton = UIButton(type: UIButtonType.Custom)
    var newGameView = NewGameView()
    var startButton = UIButton(type: UIButtonType.Custom)
    var gameNameTextEntry = UITextField(frame: CGRectZero)
 
//    var screenRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        
        newGameView.frame = UIScreen.mainScreen().bounds
        newGameView.backgroundColor = UIColor.brownColor()
        self.navigationItem.hidesBackButton = true
        
        backButton.frame = CGRectMake(50,50, 200, 50)
        backButton.center = CGPointMake(CGRectGetMidX(screenRect) * 0.40,CGRectGetMaxY(screenRect) * 0.15)
        backButton
            .addTarget(self, action: #selector(NewGameViewController.BackButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.backgroundColor = UIColor.grayColor()
        
        startButton.frame = CGRectMake(50,50, 200, 50)
        startButton.center = CGPointMake(CGRectGetMidX(screenRect), CGRectGetMaxY(screenRect) * 0.85)
        startButton
            .addTarget(self, action: #selector(NewGameViewController.StartButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        startButton.setTitle("Start Game",forState: UIControlState.Normal)
        startButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        startButton.backgroundColor = UIColor.grayColor()
        
        
        easyButton.frame = CGRectMake(50,50, 50, 50)
        easyButton.center = CGPointMake(CGRectGetMaxX(screenRect) * 0.70,CGRectGetMaxY(screenRect) * 0.70)
        easyButton.setTitle("Easy", forState: UIControlState.Normal)
        easyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        easyButton.backgroundColor = UIColor.darkGrayColor()
        easyButton.addTarget(self, action: #selector(NewGameViewController.EasyButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        hardButton.frame = CGRectMake(50,50, 50, 50)
        hardButton.center = CGPointMake(CGRectGetMaxX(screenRect) * 0.80,CGRectGetMaxY(screenRect) * 0.70)
        hardButton.setTitle("Hard", forState: UIControlState.Normal)
        hardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        hardButton.backgroundColor = UIColor.darkGrayColor()
        hardButton.addTarget(self, action: #selector(NewGameViewController.HardButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        gameNameTextEntry.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height * 0.5 + 40, 150, 20)
        gameNameTextEntry.textAlignment = NSTextAlignment.Center
        gameNameTextEntry.font = UIFont.systemFontOfSize(15)
        gameNameTextEntry.textColor = UIColor.blackColor()
        gameNameTextEntry.borderStyle = UITextBorderStyle.RoundedRect
        gameNameTextEntry.autocorrectionType = UITextAutocorrectionType.No
        gameNameTextEntry.keyboardType = UIKeyboardType.Default
        gameNameTextEntry.returnKeyType = UIReturnKeyType.Done
        gameNameTextEntry.clearButtonMode = UITextFieldViewMode.WhileEditing;
        gameNameTextEntry.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        gameNameTextEntry.center.x = screenRect.midX
        gameNameTextEntry.center.y = screenRect.midY + 40
        
        
        self.newGameView.addSubview(backButton)
        self.newGameView.addSubview(easyButton)
        self.newGameView.addSubview(hardButton)
        self.newGameView.addSubview(startButton)
        self.newGameView.addSubview(gameNameTextEntry)
        self.view.addSubview(newGameView)
        
    }
    
    
    func BackButtonPressed(){
        print("Back button pressed")
    }
    
    func StartButtonPressed(){
        print("Start Button Pressed")
    }
    
    func EasyButtonPressed(){
        diff = .EASY
        easyButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        hardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        print("Easy Difficulty is \(diff.debugDescription)")
    }
    
    func HardButtonPressed(){
        diff = .HARD
        hardButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        easyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        print("Hard Difficulty is \(diff.debugDescription)")
    }
}

