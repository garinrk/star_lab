//
//  NewGameViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol NewGameViewControllerDelegate: class {
    func newGamePressedBack()
    func newGamePressedStart(name: String, difficulty: DifficultyMode)
}

class NewGameViewController : UIViewController, UITextFieldDelegate{
    
    var screenRect = UIScreen.mainScreen().bounds
    var diff : DifficultyMode? = nil
    var backButton = UIButton(type: UIButtonType.Custom)
    var easyButton = UIButton(type: UIButtonType.Custom)
    var hardButton = UIButton(type: UIButtonType.Custom)
    var newGameView = NewGameView()
    var startButton = UIButton(type: UIButtonType.Custom)
    var gameNameTextEntry = UITextField(frame: CGRectZero)
    var _audioManager : AudioManager = AudioManager.sharedInstance

    
    var gvc : GameViewController?
    
    weak var delegate: NewGameViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        
        newGameView.frame = UIScreen.mainScreen().bounds
        newGameView.backgroundColor = UIColor.brownColor()
        //hide back button and top bar
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.hidden = true
        
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
        startButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)
        startButton.backgroundColor = UIColor.redColor()
        
        
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
        
        
        gameNameTextEntry.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height * 0.5 + 40, 150, 40)
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
        gameNameTextEntry.delegate = self
        
        self.startButton.enabled = false
        self.newGameView.addSubview(backButton)
        self.newGameView.addSubview(easyButton)
        self.newGameView.addSubview(hardButton)
        self.newGameView.addSubview(startButton)
        self.newGameView.addSubview(gameNameTextEntry)
        self.view.addSubview(newGameView)
        
    }
    
    
    func BackButtonPressed(){
        delegate?.newGamePressedBack()
    }
    
    func StartButtonPressed(){
        delegate?.newGamePressedStart(gameNameTextEntry.text!, difficulty: diff!)
    }
    
    func EasyButtonPressed(){
        diff = .Easy
        easyButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        hardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        CheckForLegal()
        _audioManager.PlayAudio(SoundType.Confirm)
    }
    
    func HardButtonPressed(){
        diff = .Hard
        hardButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        easyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        CheckForLegal()
        _audioManager.PlayAudio(SoundType.Confirm)

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.gameNameTextEntry.endEditing(true)
        CheckForLegal()
        
        return false
    }
    
    /**
     Checks to make sure that a difficulty has been set, and that a player's name has
     been input into the text field. Enables the start game button if so.
     */
    func CheckForLegal(){
        //did they set a difficulty?
        if diff == .Hard || diff == .Easy {
            if self.gameNameTextEntry.text != ""{
                startButton.backgroundColor = UIColor.greenColor()
                startButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                self.startButton.enabled = true
            }
        }
    }
}

