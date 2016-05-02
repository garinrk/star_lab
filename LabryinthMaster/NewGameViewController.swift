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

    var newGameView = NewGameView()

    var _audioManager : AudioManager = AudioManager.sharedInstance

    
    var gvc : GameViewController?
    
    weak var delegate: NewGameViewControllerDelegate? = nil
    
    var backgroundImage = UIImage(named: "space1.jpg")
    var backgroundImageView = UIImageView(frame: CGRectZero)
    
    override func viewDidLoad() {
        
        newGameView.frame = UIScreen.mainScreen().bounds
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(newGameView)

        newGameView.backButton
            .addTarget(self, action: #selector(NewGameViewController.BackButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        newGameView.startButton
            .addTarget(self, action: #selector(NewGameViewController.StartButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        newGameView.easyButton.addTarget(self, action: #selector(NewGameViewController.EasyButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        newGameView.hardButton.addTarget(self, action: #selector(NewGameViewController.HardButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        newGameView.gameNameTextEntry.delegate = self
        
        newGameView.startButton.enabled = false
    }
    
    
    func BackButtonPressed(){
        delegate?.newGamePressedBack()
    }
    
    func StartButtonPressed(){
        delegate?.newGamePressedStart(newGameView.gameNameTextEntry.text!, difficulty: diff!)
    }
    
    func EasyButtonPressed(){
        diff = .Easy
        newGameView.easyButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        newGameView.hardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        CheckForLegal()
        _audioManager.PlayAudio(SoundType.Confirm)
    }
    
    func HardButtonPressed(){
        diff = .Hard
        newGameView.hardButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        newGameView.easyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        CheckForLegal()
        _audioManager.PlayAudio(SoundType.Confirm)

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        newGameView.gameNameTextEntry.endEditing(true)
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
            if newGameView.gameNameTextEntry.text != ""{
                newGameView.startButton.backgroundColor = UIColor.greenColor()
                newGameView.startButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                newGameView.startButton.enabled = true
            }
        }
    }
}

