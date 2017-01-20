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
    func newGamePressedStart(_ name: String, difficulty: DifficultyMode)
}

class NewGameViewController : UIViewController, UITextFieldDelegate{
    
    var screenRect = UIScreen.main.bounds
    var diff : DifficultyMode? = nil

    var newGameView = NewGameView()

    var _audioManager : AudioManager = AudioManager.sharedInstance

    
    var gvc : GameViewController?
    
    weak var delegate: NewGameViewControllerDelegate? = nil
    
    var backgroundImage = UIImage(named: "space1.jpg")
    var backgroundImageView = UIImageView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        
        newGameView.frame = UIScreen.main.bounds
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(newGameView)

        newGameView.backButton
            .addTarget(self, action: #selector(NewGameViewController.BackButtonPressed), for: UIControlEvents.touchUpInside)
        newGameView.startButton
            .addTarget(self, action: #selector(NewGameViewController.StartButtonPressed), for: UIControlEvents.touchUpInside)
        newGameView.easyButton.addTarget(self, action: #selector(NewGameViewController.EasyButtonPressed), for: UIControlEvents.touchUpInside)
        newGameView.hardButton.addTarget(self, action: #selector(NewGameViewController.HardButtonPressed), for: UIControlEvents.touchUpInside)
        
        newGameView.gameNameTextEntry.delegate = self
        
        newGameView.startButton.isEnabled = false
    }
    
    
    func BackButtonPressed(){
        delegate?.newGamePressedBack()
    }
    
    func StartButtonPressed(){
        delegate?.newGamePressedStart(newGameView.gameNameTextEntry.text!, difficulty: diff!)
    }
    
    func EasyButtonPressed(){
        diff = .easy
        newGameView.easyButton.setTitleColor(UIColor.white, for: UIControlState())
        newGameView.easyButton.backgroundColor = UIColor.green
        newGameView.hardButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        newGameView.hardButton.setTitleColor(UIColor.black, for: UIControlState())
        CheckForLegal()
        _audioManager.PlayAudio(SoundType.confirm)
    }
    
    func HardButtonPressed(){
        diff = .hard
        newGameView.hardButton.setTitleColor(UIColor.white, for: UIControlState())
        newGameView.hardButton.backgroundColor = UIColor.green
        newGameView.easyButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        newGameView.easyButton.setTitleColor(UIColor.black, for: UIControlState())
        CheckForLegal()
        _audioManager.PlayAudio(SoundType.confirm)

    }
    //MARK: UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        CheckForLegal()
        
        return false
    }
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nil
    }
    

    

    /**
     Checks to make sure that a difficulty has been set, and that a player's name has
     been input into the text field. Enables the start game button if so.
     */
    func CheckForLegal(){
        //did they set a difficulty?
        if diff == .hard || diff == .easy {
            if newGameView.gameNameTextEntry.text != ""{
                newGameView.startButton.backgroundColor = UIColor.green
                newGameView.startButton.setTitleColor(UIColor.black, for: UIControlState())
                newGameView.startButton.isEnabled = true
            }
        }
    }
}

