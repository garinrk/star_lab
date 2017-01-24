//
//  PauseViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol PauseViewDelegate : class {
    func pausePressedUnpause()
    func pausePressedQuit()
}

class PauseViewController : UIViewController{
    
    var pauseView  = PauseView()

    var screenRect = UIScreen.main.bounds
    
    var _audio : AudioManager = AudioManager.sharedInstance
    var _gameManager : GameManager = GameManager.sharedInstance
    
    weak var delegate: PauseViewDelegate? = nil
    
    var backgroundImage = UIImage(named: "halo.jpg")
    var backgroundImageView = UIImageView(frame: CGRect.zero)
    
    override func viewDidLoad() {        
        pauseView.frame = UIScreen.main.bounds
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        pauseView.addSubview(backgroundImageView)
        self.view.addSubview(pauseView)
        
        //set up sliders with handler methods
        pauseView.musicSlider.addTarget(self, action: #selector(PauseViewController.MusicSliderChanged), for: UIControlEvents.valueChanged)
        pauseView.fxSlider.addTarget(self, action: #selector(PauseViewController.FxSliderChanged), for: UIControlEvents.valueChanged)
        pauseView.resumeButton
            .addTarget(self, action: #selector(PauseViewController.ResumeButtonPressed), for: UIControlEvents.touchUpInside)
        pauseView.quitButton
            .addTarget(self, action: #selector(PauseViewController.QuitButtonPressed), for: UIControlEvents.touchUpInside)
          
        pauseView.fxSlider.value = _audio.effectsVolume
        pauseView.musicSlider.value = _audio.mainMusicVolume
    }
    
    /**
     The music's volume has been modified
     */
    func MusicSliderChanged(){
//        print("Music: \(musicSlider!.value)")
        _audio.mainMusicVolume = pauseView.musicSlider.value
    }
    
    /**
     The FX volume has been modified
     */
    func FxSliderChanged(){
//        print("FX: \(fxSlider!.value)")
        _audio.effectsVolume = pauseView.fxSlider.value
    }
    
    func ResumeButtonPressed(){
        delegate?.pausePressedUnpause()
    }
    
    func QuitButtonPressed(){
        delegate?.pausePressedQuit()
    }
}
