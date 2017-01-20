//
//  OptionsViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/18/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol OptionsViewControllerDelegate: class {
    func optionsPressedBack()
}

class OptionsViewController : UIViewController{

    var optionsView : OptionsView!
    var screenRect = UIScreen.main.bounds
    var diff : DifficultyMode? = .easy
    
    var backgroundImage = UIImage(named: "space3.jpg")
    var backgroundImageView = UIImageView(frame: CGRect.zero)
    
    var _audio : AudioManager = AudioManager.sharedInstance
    var _scoreManager : ScoreManager = ScoreManager.sharedInstance
    
    weak var delegate: OptionsViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        //set up options view and hide back button
        
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        optionsView = OptionsView(frame: screenRect)
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(optionsView!)
        
        //TODO: Check prefs to make sure that the correct difficulty is selected at
        //first
        
        //set up sliders with handler methods
        optionsView.musicSlider.addTarget(self, action: #selector(OptionsViewController.MusicSliderChanged), for: UIControlEvents.valueChanged)
        optionsView.fxSlider.addTarget(self, action: #selector(OptionsViewController.FxSliderChanged), for: UIControlEvents.valueChanged)
        
        optionsView.fxSlider.value = _audio.effectsVolume
        optionsView.musicSlider.value = _audio.mainMusicVolume

        optionsView.backButton
            .addTarget(self, action: #selector(OptionsViewController.BackButtonPressed), for: UIControlEvents.touchUpInside)

    }
    
    /**
     The music's volume has been modified
     */
    func MusicSliderChanged(){
        print("Music: \(optionsView.musicSlider.value)")
        _audio.mainMusicVolume = optionsView.musicSlider.value
        _audio.SetVolumes()
    }
    
    /**
     The FX volume has been modified
     */
    func FxSliderChanged(){
        print("FX: \(optionsView.fxSlider.value)")
        _audio.effectsVolume = optionsView.fxSlider.value
        _audio.SetVolumes()
    }
    
    func BackButtonPressed(){
        delegate?.optionsPressedBack()
    }
    
    
    
}
