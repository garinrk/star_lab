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

    var screenRect = UIScreen.mainScreen().bounds
    
    var _audio : AudioManager = AudioManager.sharedInstance
    var _gameManager : GameManager = GameManager.sharedInstance
    
    weak var delegate: PauseViewDelegate? = nil
    
    var backgroundImage = UIImage(named: "halo.jpg")
    var backgroundImageView = UIImageView(frame: CGRectZero)
    
    override func viewDidLoad() {
        
        pauseView.frame = UIScreen.mainScreen().bounds
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        pauseView.addSubview(backgroundImageView)
        self.view.addSubview(pauseView)
        
        //set up sliders with handler methods
        pauseView.musicSlider.addTarget(self, action: #selector(PauseViewController.MusicSliderChanged), forControlEvents: UIControlEvents.ValueChanged)
        pauseView.fxSlider.addTarget(self, action: #selector(PauseViewController.FxSliderChanged), forControlEvents: UIControlEvents.ValueChanged)
        pauseView.resumeButton
            .addTarget(self, action: #selector(PauseViewController.ResumeButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        pauseView.quitButton
            .addTarget(self, action: #selector(PauseViewController.QuitButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
          
        pauseView.fxSlider.value = _audio.effectsVolume
        pauseView.musicSlider.value = _audio.mainMusicVolume
    }
    
    /**
     The music's volume has been modified
     */
    func MusicSliderChanged(){
//        print("Music: \(musicSlider!.value)")
        _audio.mainMusicVolume = pauseView.musicSlider.value
        _audio.SetVolumes()
    }
    
    /**
     The FX volume has been modified
     */
    func FxSliderChanged(){
//        print("FX: \(fxSlider!.value)")
        _audio.effectsVolume = pauseView.fxSlider.value
        _audio.SetVolumes()
    }
    
    
    func ResumeButtonPressed(){
        delegate?.pausePressedUnpause()
    }
    
    func QuitButtonPressed(){
        delegate?.pausePressedQuit()
    }
}
