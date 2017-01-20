//
//  MainMenuViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/18/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol MainMenuViewControllerDelegate: class {
    func startNewGame(_ name: String, difficulty: DifficultyMode)
}

class MainMenuViewController : UIViewController, NewGameViewControllerDelegate, OptionsViewControllerDelegate, HighScoreViewControllerDelegate {
    
    var mmview = MainMenuView()
    
    var ngvc : NewGameViewController?
    var ovc : OptionsViewController?
    var hsvc : HighScoreViewController?
    var newGameButton = UIButton(type: UIButtonType.custom)
    var optionsButton = UIButton(type: UIButtonType.custom)
    var scoresButton = UIButton(type: UIButtonType.custom)
    var screenRect : CGRect = UIScreen.main.bounds
    var _audioManager : AudioManager = AudioManager.sharedInstance
    
    weak var delegate: MainMenuViewControllerDelegate? = nil
    var backgroundImage = UIImage(named: "space2.jpg")
    var backgroundImageView = UIImageView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        //set view
        mmview.frame = UIScreen.main.bounds
        mmview.backgroundColor = UIColor(white: 0, alpha: 0)
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(mmview)
        
        //play music
        _audioManager.PlayAudio(SoundType.mainMusic)
        

        
        mmview.newGameButton
            .addTarget(self, action: #selector(MainMenuViewController.NewGameButtonPressed), for: UIControlEvents.touchUpInside)
        
        mmview.optionsButton
            .addTarget(self, action: #selector(MainMenuViewController.OptionsButtonPressed), for: UIControlEvents.touchUpInside)
        
        mmview.scoresButton
            .addTarget(self, action: #selector(MainMenuViewController.ScoresButtonPressed), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(mmview)
    }
    
    func NewGameButtonPressed(){
        ngvc = NewGameViewController()
        ngvc!.delegate = self
        _audioManager.PlayAudio(SoundType.confirm)
        self.present(ngvc!, animated: false, completion: nil)
    }
    
    func OptionsButtonPressed(){
        ovc = OptionsViewController()
        ovc!.delegate = self
        _audioManager.PlayAudio(SoundType.confirm)
        self.present(ovc!, animated: false, completion: nil)
    }
    
    func ScoresButtonPressed(){
        hsvc = HighScoreViewController()
        hsvc!.delegate = self
        _audioManager.PlayAudio(SoundType.confirm)
        self.present(hsvc!, animated: false, completion: nil)
    }
    
    // MARK: NewGameViewControllerDelegate functions
    func newGamePressedBack() {
        _audioManager.PlayAudio(SoundType.confirm)
        self.dismiss(animated: false, completion: nil)
    }
    
    func newGamePressedStart(_ name: String, difficulty: DifficultyMode) {
        self.dismiss(animated: false, completion: nil)
        delegate?.startNewGame(name, difficulty: difficulty)
    }
    
    // MARK: OptionsViewControllerDelegate functions 
    func optionsPressedBack() {
        _audioManager.PlayAudio(SoundType.confirm)
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: HighScoreViewControllerDelegate functions
    func highScorePressedBack() {
        _audioManager.PlayAudio(SoundType.confirm)
        self.dismiss(animated: false, completion: nil)
    }
    
    
}
