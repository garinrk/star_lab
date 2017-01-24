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
    
    weak var delegate: MainMenuViewControllerDelegate? = nil

    fileprivate let audioManager: AudioManager = AudioManager.sharedInstance
    
    fileprivate var contentView: MainMenuView {
        return view as! MainMenuView
    }
    
    override func loadView() {
        view = MainMenuView()
    }
    
    override func viewDidLoad() {
        audioManager.PlayAudio(type: SoundType.mainMusic)
        
        contentView.newGameButton
            .addTarget(self, action: #selector(MainMenuViewController.NewGameButtonPressed), for: UIControlEvents.touchUpInside)
        contentView.optionsButton
            .addTarget(self, action: #selector(MainMenuViewController.OptionsButtonPressed), for: UIControlEvents.touchUpInside)
        contentView.scoresButton
            .addTarget(self, action: #selector(MainMenuViewController.ScoresButtonPressed), for: UIControlEvents.touchUpInside)
    }
    
    func NewGameButtonPressed(){
        let ngvc = NewGameViewController()
        ngvc.delegate = self
        audioManager.PlayAudio(type: SoundType.confirm)
        self.present(ngvc, animated: false, completion: nil)
    }
    
    func OptionsButtonPressed(){
        let ovc = OptionsViewController()
        ovc.delegate = self
        audioManager.PlayAudio(type: SoundType.confirm)
        self.present(ovc, animated: false, completion: nil)
    }
    
    func ScoresButtonPressed(){
        let hsvc = HighScoreViewController()
        hsvc.delegate = self
        audioManager.PlayAudio(type: SoundType.confirm)
        self.present(hsvc, animated: false, completion: nil)
    }
    
    // MARK:- NewGameViewControllerDelegate functions
    
    func newGamePressedBack() {
        audioManager.PlayAudio(type: SoundType.confirm)
        self.dismiss(animated: false, completion: nil)
    }
    
    func newGamePressedStart(name: String, difficulty: DifficultyMode) {
        self.dismiss(animated: false, completion: nil)
        delegate?.startNewGame(name: name, difficulty: difficulty)
    }
    
    // MARK:- OptionsViewControllerDelegate functions
    
    func optionsPressedBack() {
        audioManager.PlayAudio(type: SoundType.confirm)
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK:- HighScoreViewControllerDelegate functions
    
    func highScorePressedBack() {
        audioManager.PlayAudio(type: SoundType.confirm)
        self.dismiss(animated: false, completion: nil)
    }
}
