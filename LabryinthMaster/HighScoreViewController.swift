//
//  HighScoreViewController.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol HighScoreViewControllerDelegate: class {
    func highScorePressedBack()
}

class HighScoreViewController : UIViewController{
    var screenRect = UIScreen.mainScreen().bounds
    var highScore = HighScoreView(frame: UIScreen.mainScreen().bounds)
    
    weak var delegate: HighScoreViewControllerDelegate? = nil
    var backgroundImage = UIImage(named: "space6.jpg")
    var backgroundImageView = UIImageView(frame: CGRectZero)
    
    override func viewDidLoad() {
        
//        highScore.frame =
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(highScore)
        
        highScore.backButton
            .addTarget(self, action: #selector(HighScoreViewController.BackButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func BackButtonPressed(){
        delegate?.highScorePressedBack()
    }
    
}
