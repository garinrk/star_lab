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
            .addTarget(self, action: #selector(GameOverViewController.QuitButtonPressed), for: UIControlEvents.touchUpInside)
        contentView.tryAgainButton
            .addTarget(self, action: #selector(GameOverViewController.TryAgainPressed), for: UIControlEvents.touchUpInside)
    }
    
    func TryAgainPressed(){
        delegate?.gameOverPressedRetry()
    }
    
    func QuitButtonPressed(){
        delegate?.gameOverPressedExit()
    }    
}
