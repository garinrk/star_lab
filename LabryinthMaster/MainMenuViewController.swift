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

    var screenRect : CGRect = UIScreen.mainScreen().bounds
    var _audioManager : AudioManager = AudioManager.sharedInstance
    
    weak var delegate: MainMenuViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        //set view
        mmview.frame = UIScreen.mainScreen().bounds
        mmview.backgroundColor = UIColor.brownColor()

        //play music
        _audioManager.PlayAudio(SoundType.MainMusic)
        

        
        mmview.newGameButton
            .addTarget(self, action: #selector(MainMenuViewController.NewGameButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        mmview.optionsButton
            .addTarget(self, action: #selector(MainMenuViewController.OptionsButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        mmview.scoresButton
            .addTarget(self, action: #selector(MainMenuViewController.ScoresButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
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
