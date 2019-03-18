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
    var lifetimeScore : Int = 0
    
    weak var delegate: GameOverViewControllerDelegate? = nil
    
    fileprivate var contentView: GameOverView {
        return view as! GameOverView
    }
    
    override func loadView() {
        self.view = GameOverView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.lifetimeScoreAmt = lifetimeScore
        
        contentView.quitButton
            .addTarget(self, action: #selector(GameOverViewController.QuitButtonPressed), for: UIControl.Event.touchUpInside)
        contentView.tryAgainButton
            .addTarget(self, action: #selector(GameOverViewController.TryAgainPressed), for: UIControl.Event.touchUpInside)
    }
    
    @objc func TryAgainPressed(){
        delegate?.gameOverPressedRetry()
    }
    
    @objc func QuitButtonPressed(){
        delegate?.gameOverPressedExit()
    }    
}
