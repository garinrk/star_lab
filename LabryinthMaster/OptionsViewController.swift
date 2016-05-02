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
    //difficulty, fx and music level
    var musicSlider : UISlider?
    var fxSlider : UISlider?
//    var easyButton = UIButton(type: UIButtonType.Custom)
//    var hardButton = UIButton(type: UIButtonType.Custom)
    var optionsView = OptionsView()
    var screenRect = UIScreen.mainScreen().bounds
    var diff : DifficultyMode? = .Easy
    var backButton = UIButton(type: UIButtonType.Custom)
    
//    var hardDifficultySelected = false
//    var easyDifficultySelected = false
    
    var backgroundImage = UIImage(named: "space3.jpg")
    var backgroundImageView = UIImageView(frame: CGRectZero)
    
    var _audio : AudioManager = AudioManager.sharedInstance
    var _scoreManager : ScoreManager = ScoreManager.sharedInstance
    
    weak var delegate: OptionsViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        //set up options view and hide back button
        optionsView.frame = UIScreen.mainScreen().bounds
        
        
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        optionsView.addSubview(backgroundImageView)
        self.view.addSubview(optionsView)
        //hide back button and top bar
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.hidden = true
        
        //TODO: Check prefs to make sure that the correct difficulty is selected at
        //first
        
        //set up sliders with handler methods
        musicSlider = UISlider(frame: CGRectMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect), 200, 50))
        fxSlider = UISlider(frame: CGRectMake(CGRectGetMidX(screenRect), CGRectGetMidY(screenRect), 200, 50))
        
        musicSlider!.center = CGPointMake(CGRectGetMaxX(screenRect) * 0.75,CGRectGetMaxY(screenRect) * 0.55)
        fxSlider!.center = CGPointMake(CGRectGetMaxX(screenRect) * 0.75,CGRectGetMaxY(screenRect) * 0.60)
        musicSlider!.addTarget(self, action: #selector(OptionsViewController.MusicSliderChanged), forControlEvents: UIControlEvents.ValueChanged)
        fxSlider!.addTarget(self, action: #selector(OptionsViewController.FxSliderChanged), forControlEvents: UIControlEvents.ValueChanged)
//        
//        
//        easyButton.frame = CGRectMake(50,50, 50, 50)
//        easyButton.center = CGPointMake(CGRectGetMaxX(screenRect) * 0.70,CGRectGetMaxY(screenRect) * 0.45)
//        easyButton.setTitle("Easy", forState: UIControlState.Normal)
//        easyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        easyButton.backgroundColor = UIColor.darkGrayColor()
//        easyButton.addTarget(self, action: #selector(OptionsViewController.EasyButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
//        
//        hardButton.frame = CGRectMake(50,50, 50, 50)
//        hardButton.center = CGPointMake(CGRectGetMaxX(screenRect) * 0.80,CGRectGetMaxY(screenRect) * 0.45)
//        hardButton.setTitle("Hard", forState: UIControlState.Normal)
//        hardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        hardButton.backgroundColor = UIColor.darkGrayColor()
//        hardButton.addTarget(self, action: #selector(OptionsViewController.HardButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        backButton.frame = CGRectMake(50,50, 200, 50)
        backButton.center = CGPointMake(CGRectGetMidX(screenRect) * 0.40,CGRectGetMaxY(screenRect) * 0.15)
        backButton
            .addTarget(self, action: #selector(OptionsViewController.BackButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("Back to Menu", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.layer.borderWidth = 5
        backButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        fxSlider?.value = _audio.effectsVolume
        musicSlider?.value = _audio.mainMusicVolume
        //add to optionsview
        self.optionsView.addSubview(backButton)
//        self.optionsView.addSubview(easyButton)
//        self.optionsView.addSubview(hardButton)
        self.optionsView.addSubview(musicSlider!)
        self.optionsView.addSubview(fxSlider!)
        self.view.addSubview(optionsView)
        
        //        let ac = UIAlertController(title: "Hello!", message: "This is a test.", preferredStyle: .ActionSheet)
        //
        //        let popover = ac.popoverPresentationController
        //        popover?.sourceView = view
        //        popover?.sourceRect = CGRect(x: 32, y: 32, width: 64, height: 64)
        //
        //        presentViewController(ac, animated: true, completion: nil)
    }
    
    /**
     The music's volume has been modified
     */
    func MusicSliderChanged(){
        print("Music: \(musicSlider!.value)")
        _audio.mainMusicVolume = musicSlider!.value
        _audio.SetVolumes()
    }
    
    /**
     The FX volume has been modified
     */
    func FxSliderChanged(){
        print("FX: \(fxSlider!.value)")
        _audio.effectsVolume = fxSlider!.value
        _audio.SetVolumes()
    }
//    
//    func EasyButtonPressed(){
//        diff = .Easy
//        easyButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        hardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        print("Difficulty is \(diff.debugDescription)")
//    }
//    
//    func HardButtonPressed(){
//        diff = .Hard
//        hardButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        easyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        print("Difficulty is \(diff.debugDescription)")
//    }
    
    func BackButtonPressed(){
//        print("Back Button Pressed")
//        self.navigationController?.popViewControllerAnimated(true)
        delegate?.optionsPressedBack()
    }
    
    
    
}
