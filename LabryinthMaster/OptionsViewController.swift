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

class OptionsViewController : UIViewController {

    weak var delegate: OptionsViewControllerDelegate? = nil
    
    fileprivate var audioManager: AudioManager = AudioManager.sharedInstance
    fileprivate var scoreManager: ScoreManager = ScoreManager.sharedInstance
    
    fileprivate var contentView: OptionsView {
        return view as! OptionsView
    }
    
    override func loadView() {
        view = OptionsView()
    }
    
    override func viewDidLoad() {
        contentView.fxSlider.value = audioManager.effectsVolume
        contentView.musicSlider.value = audioManager.mainMusicVolume

        contentView.musicSlider.addTarget(self, action: #selector(musicSliderChanged), for: UIControlEvents.valueChanged)
        contentView.fxSlider.addTarget(self, action: #selector(fxSliderChanged), for: UIControlEvents.valueChanged)
        contentView.backButton.addTarget(self, action: #selector(backButtonPressed), for: UIControlEvents.touchUpInside)
    }
    
    @objc fileprivate func musicSliderChanged() {
        audioManager.mainMusicVolume = contentView.musicSlider.value
    }
    
    @objc fileprivate func fxSliderChanged() {
        audioManager.effectsVolume = contentView.fxSlider.value
    }
    
    @objc fileprivate func backButtonPressed() {
        delegate?.optionsPressedBack()
    }
}
