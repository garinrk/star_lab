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
    
    var lifetimeScore: Int = 0
    
    weak var delegate: LevelCompleteViewControllerDelegate? = nil
        
    fileprivate var contentView: LevelCompleteView {
        return view as! LevelCompleteView
    }
    
    override func loadView() {
        view = LevelCompleteView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.lifetimeScoreAmt = lifetimeScore
        
        contentView.quitButton.addTarget(self, action: #selector(LevelCompleteViewController.QuitButtonPressed), for: UIControlEvents.touchUpInside)
        contentView.continueButton.addTarget(self, action: #selector(LevelCompleteViewController.ContinueButtonPressed), for: UIControlEvents.touchUpInside)
    }
    
    func ContinueButtonPressed(){
        delegate?.levelCompletePressedRetry()
    }
    
    func QuitButtonPressed(){
        delegate?.levelCompletePressedExit()
    }
}
