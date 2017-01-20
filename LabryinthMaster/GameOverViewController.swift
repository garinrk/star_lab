//
//  LevelCompleteViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol GameOverViewControllerDelegate: class {
    func gameOverPressedRetry()
    func gameOverPressedExit()
}

class GameOverViewController : UIViewController{
    
    var gameOverView = GameOverView()
    var tryAgainButton = UIButton(type: UIButtonType.custom)
    var quitButton = UIButton(type: UIButtonType.custom)
    var screenRect = UIScreen.main.bounds
    var lifetimeScore: Int = 0
    
    weak var delegate: GameOverViewControllerDelegate? = nil
    
    var backgroundImage = UIImage(named: "space5.jpg")
    var backgroundImageView = UIImageView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        
        gameOverView.lifetimeScoreAmt = lifetimeScore
        gameOverView.frame = UIScreen.main.bounds
        
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(gameOverView)
        
        quitButton.frame = CGRect(x: 50,y: 50, width: 200, height: 50)
        quitButton.center = CGPoint(x: screenRect.midX + 200, y: UIScreen.main.bounds.maxY * 0.90)
        quitButton
            .addTarget(self, action: #selector(GameOverViewController.QuitButtonPressed), for: UIControlEvents.touchUpInside)
        quitButton.setTitle("Quit",for: UIControlState())
        quitButton.setTitleColor(UIColor.white, for: UIControlState())
        quitButton.layer.borderWidth = 5
        quitButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderColor = UIColor.white.cgColor
        
        tryAgainButton.frame = CGRect(x: 50,y: 50, width: 200, height: 50)
        tryAgainButton.center = CGPoint(x: screenRect.midX - 200,y: UIScreen.main.bounds.maxY * 0.90)
        tryAgainButton
            .addTarget(self, action: #selector(GameOverViewController.TryAgainPressed), for: UIControlEvents.touchUpInside)
        tryAgainButton.setTitle("Try Again", for: UIControlState())
        tryAgainButton.setTitleColor(UIColor.white, for: UIControlState())
        tryAgainButton.layer.borderWidth = 5
        tryAgainButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        tryAgainButton.layer.cornerRadius = 5
        tryAgainButton.layer.borderColor = UIColor.white.cgColor
        
        self.gameOverView.addSubview(quitButton)
        self.gameOverView.addSubview(tryAgainButton)
    }
    
    func TryAgainPressed(){
        delegate?.gameOverPressedRetry()
    }
    
    func QuitButtonPressed(){
        delegate?.gameOverPressedExit()
    }    
}
