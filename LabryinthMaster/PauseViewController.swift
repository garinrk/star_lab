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

//protocol GameManagerDelegate: class {
//    //    func redrawMaze()
//    func GameOverCall()
//    func WinGameCall()
//}

class PauseViewController : UIViewController{
    
    var pauseView  = PauseView()
    var resumeButton = UIButton(type: UIButtonType.Custom)
    var quitButton = UIButton(type: UIButtonType.Custom)
    var musicSlider : UISlider?
    var fxSlider : UISlider?
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
        
        //hide back button and top bar
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.hidden = true
        
        //set up sliders with handler methods
        musicSlider = UISlider(frame: CGRectMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect), 200, 50))
        fxSlider = UISlider(frame: CGRectMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect), 200, 50))
        
        musicSlider!.center = CGPointMake(CGRectGetMaxX(screenRect) * 0.75,CGRectGetMaxY(screenRect) * 0.55)
        fxSlider!.center = CGPointMake(CGRectGetMaxX(screenRect) * 0.75,CGRectGetMaxY(screenRect) * 0.60)
        musicSlider!.addTarget(self, action: #selector(PauseViewController.MusicSliderChanged), forControlEvents: UIControlEvents.ValueChanged)
        fxSlider!.addTarget(self, action: #selector(PauseViewController.FxSliderChanged), forControlEvents: UIControlEvents.ValueChanged)
        
        resumeButton.frame = CGRectMake(50,50, 200, 50)
        resumeButton.center = CGPointMake(CGRectGetMidX(screenRect), CGRectGetMaxY(screenRect) * 0.85)
        
        resumeButton
            .addTarget(self, action: #selector(PauseViewController.ResumeButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        resumeButton.setTitle("Resume Game",forState: UIControlState.Normal)
        resumeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        resumeButton.layer.borderWidth = 5
        resumeButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        resumeButton.layer.cornerRadius = 5
        resumeButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        quitButton.frame = CGRectMake(50,50, 200, 50)
        quitButton.center = CGPointMake(CGRectGetMidX(screenRect) * 0.40,CGRectGetMaxY(screenRect) * 0.15)
        quitButton
            .addTarget(self, action: #selector(PauseViewController.QuitButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        quitButton.setTitle("Quit Game", forState: UIControlState.Normal)
        quitButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quitButton.layer.borderWidth = 5
        quitButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        fxSlider?.value = _audio.effectsVolume
        musicSlider?.value = _audio.mainMusicVolume
        self.pauseView.addSubview(quitButton)
        self.pauseView.addSubview(musicSlider!)
        self.pauseView.addSubview(fxSlider!)
        self.pauseView.addSubview(resumeButton)
        
    }
    
    /**
     The music's volume has been modified
     */
    func MusicSliderChanged(){
//        print("Music: \(musicSlider!.value)")
        _audio.mainMusicVolume = musicSlider!.value
        _audio.SetVolumes()
    }
    
    /**
     The FX volume has been modified
     */
    func FxSliderChanged(){
//        print("FX: \(fxSlider!.value)")
        _audio.effectsVolume = fxSlider!.value
        _audio.SetVolumes()
    }
    
    
    func ResumeButtonPressed(){
        delegate?.pausePressedUnpause()
    }
    
    func QuitButtonPressed(){
        delegate?.pausePressedQuit()
    }
}
