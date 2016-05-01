//
//  MainMenuViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/18/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol MainMenuViewControllerDelegate: class {
    func startNewGame(name: String, difficulty: DifficultyMode)
}

class MainMenuViewController : UIViewController, NewGameViewControllerDelegate, OptionsViewControllerDelegate, HighScoreViewControllerDelegate {
    
    var mmview = MainMenuView()
    
    var ngvc : NewGameViewController?
    var ovc : OptionsViewController?
    var hsvc : HighScoreViewController?
    var newGameButton = UIButton(type: UIButtonType.Custom)
    var optionsButton = UIButton(type: UIButtonType.Custom)
    var scoresButton = UIButton(type: UIButtonType.Custom)
    var screenRect : CGRect = UIScreen.mainScreen().bounds
    var _audioManager : AudioManager = AudioManager.sharedInstance
    
    weak var delegate: MainMenuViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        mmview.frame = UIScreen.mainScreen().bounds
        mmview.backgroundColor = UIColor.brownColor()
        _audioManager.PlayAudio(SoundType.MainMusic)
        newGameButton.frame = CGRectMake(50,50, 200, 50)
        newGameButton.center = CGPointMake(CGRectGetMidX(screenRect) - 200,CGRectGetMaxY(UIScreen.mainScreen().bounds) * 0.75)
        newGameButton
            .addTarget(self, action: #selector(MainMenuViewController.NewGameButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        newGameButton.setTitle("New Game", forState: UIControlState.Normal)
        newGameButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        newGameButton.backgroundColor = UIColor.grayColor()
        
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
        self.mmview.addSubview(optionsButton)
        self.mmview.addSubview(scoresButton)
        
        self.view.addSubview(mmview)
    }
    
    func NewGameButtonPressed(){
        ngvc = NewGameViewController()
        ngvc!.delegate = self
        _audioManager.PlayAudio(SoundType.Confirm)
        self.presentViewController(ngvc!, animated: false, completion: nil)
    }
    
    func OptionsButtonPressed(){
        ovc = OptionsViewController()
        ovc!.delegate = self
        _audioManager.PlayAudio(SoundType.Confirm)
        self.presentViewController(ovc!, animated: false, completion: nil)
    }
    
    func ScoresButtonPressed(){
        hsvc = HighScoreViewController()
        hsvc!.delegate = self
        _audioManager.PlayAudio(SoundType.Confirm)
        self.presentViewController(hsvc!, animated: false, completion: nil)
    }
    
    // MARK: NewGameViewControllerDelegate functions
    func newGamePressedBack() {
        _audioManager.PlayAudio(SoundType.Confirm)
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func newGamePressedStart(name: String, difficulty: DifficultyMode) {
        self.dismissViewControllerAnimated(false, completion: nil)
        delegate?.startNewGame(name, difficulty: difficulty)
    }
    
    // MARK: OptionsViewControllerDelegate functions 
    func optionsPressedBack() {
        _audioManager.PlayAudio(SoundType.Confirm)
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    // MARK: HighScoreViewControllerDelegate functions
    func highScorePressedBack() {
        _audioManager.PlayAudio(SoundType.Confirm)
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
}
