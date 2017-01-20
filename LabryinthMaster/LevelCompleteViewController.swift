//
//  LevelCompleteViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol LevelCompleteViewControllerDelegate: class {
    func levelCompletePressedRetry()
    func levelCompletePressedExit()
}

class LevelCompleteViewController : UIViewController{
    
    var completeView = LevelCompleteView()
    var continueButton = UIButton(type: UIButtonType.custom)
    var quitButton = UIButton(type: UIButtonType.custom)
    var screenRect = UIScreen.main.bounds
    var lifetimeScore: Int = 0
    
    weak var delegate: LevelCompleteViewControllerDelegate? = nil
    
    var backgroundImage = UIImage(named: "blackHole.jpg")
    var backgroundImageView = UIImageView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        
        completeView.frame = UIScreen.main.bounds
        completeView.lifetimeScoreAmt = lifetimeScore
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        completeView.addSubview(backgroundImageView)
        self.view.addSubview(completeView)
        
        quitButton.frame = CGRect(x: 50,y: 50, width: 200, height: 50)
        quitButton.center = CGPoint(x: screenRect.midX + 200, y: UIScreen.main.bounds.maxY * 0.90)
        quitButton
            .addTarget(self, action: #selector(LevelCompleteViewController.QuitButtonPressed), for: UIControlEvents.touchUpInside)
        quitButton.setTitle("Quit",for: UIControlState())
        quitButton.setTitleColor(UIColor.white, for: UIControlState())
        quitButton.layer.borderWidth = 5
        quitButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderColor = UIColor.white.cgColor
        
        continueButton.frame = CGRect(x: 50,y: 50, width: 200, height: 50)
        continueButton.center = CGPoint(x: screenRect.midX - 200,y: UIScreen.main.bounds.maxY * 0.90)
        continueButton
            .addTarget(self, action: #selector(LevelCompleteViewController.ContinueButtonPressed), for: UIControlEvents.touchUpInside)
        continueButton.setTitle("Continue", for: UIControlState())
        continueButton.setTitleColor(UIColor.white, for: UIControlState())
        continueButton.layer.borderWidth = 5
        continueButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        continueButton.layer.cornerRadius = 5
        continueButton.layer.borderColor = UIColor.white.cgColor
        
        self.completeView.addSubview(quitButton)
        self.completeView.addSubview(continueButton)
        self.view.addSubview(completeView)
    }
    
    func ContinueButtonPressed(){
        delegate?.levelCompletePressedRetry()
    }
    
    func QuitButtonPressed(){
        delegate?.levelCompletePressedExit()
    }
}
