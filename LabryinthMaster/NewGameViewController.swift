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

class NewGameViewController : UIViewController, UITextFieldDelegate {
    
    var difficulty : DifficultyMode? = nil
    weak var delegate: NewGameViewControllerDelegate? = nil
    
    fileprivate let audioManager: AudioManager = AudioManager.sharedInstance
    fileprivate let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    fileprivate var contentView: NewGameView {
        return view as! NewGameView
    }
    
    override func loadView() {
        view = NewGameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // gesture recognizer for dismissing keyboard when screen is tapped
        tapRecognizer.addTarget(self, action: #selector(screenTapped))
        tapRecognizer.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tapRecognizer)
        
        contentView.backButton.addTarget(self, action: #selector(backButtonPressed), for: UIControlEvents.touchUpInside)
        contentView.startButton.addTarget(self, action: #selector(startButtonPressed), for: UIControlEvents.touchUpInside)
        contentView.easyButton.addTarget(self, action: #selector(easyButtonPressed), for: UIControlEvents.touchUpInside)
        contentView.hardButton.addTarget(self, action: #selector(hardButtonPressed), for: UIControlEvents.touchUpInside)
        
        contentView.nameTextField.delegate = self
        
        contentView.startButton.isEnabled = false
    }
    
    /**
     Checks to make sure that a difficulty has been set, and that a player's name has
     been input into the text field. Enables the start game button if so.
     */
    fileprivate func validateAndUpdate() {
        if (difficulty != nil && contentView.nameTextField.text != "") {
            contentView.startButton.backgroundColor = UIColor.green
            contentView.startButton.isEnabled = true
        } else {
            contentView.startButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
            contentView.startButton.isEnabled = false
        }
    }
    
    //MARK:- button targets
    
    @objc fileprivate func backButtonPressed() {
        delegate?.newGamePressedBack()
    }
    
    @objc fileprivate func startButtonPressed() {
        delegate?.newGamePressedStart(name: contentView.nameTextField.text!, difficulty: difficulty!)
    }
    
    @objc fileprivate func easyButtonPressed() {
        difficulty = .easy
        contentView.easyButton.setTitleColor(UIColor.black, for: UIControlState())
        contentView.easyButton.backgroundColor = UIColor.green
        contentView.hardButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        contentView.hardButton.setTitleColor(UIColor.white, for: UIControlState())
        validateAndUpdate()
        audioManager.PlayAudio(type: SoundType.confirm)
    }
    
    @objc fileprivate func hardButtonPressed() {
        difficulty = .hard
        contentView.hardButton.setTitleColor(UIColor.black, for: UIControlState())
        contentView.hardButton.backgroundColor = UIColor.green
        contentView.easyButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        contentView.easyButton.setTitleColor(UIColor.white, for: UIControlState())
        validateAndUpdate()
        audioManager.PlayAudio(type: SoundType.confirm)
    }
    
    @objc fileprivate func screenTapped() {
        contentView.endEditing(true)
        validateAndUpdate()
    }
    
    //MARK:- UITextFieldDelegate Methods
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        return true
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        validateAndUpdate()
    }
}

