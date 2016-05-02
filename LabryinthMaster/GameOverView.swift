//
//  LevelCompleteView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class GameOverView : UIView{
    var gameOverLabel = UILabel()
    var scoreLabel = UILabel()
    var lifetimeScore = UILabel()
    var screenRect = UIScreen.mainScreen().bounds
    var _gameManager : GameManager = GameManager.sharedInstance
    
    var lifetimeScoreAmt: Int = 0
    
    var titleImage = UIImage(named: "gameover.png")
    var titleImageBackground = UIImageView(frame: CGRectZero)
    
    override func drawRect(rect: CGRect) {
        
//        gameOverLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 400, 100)
        titleImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 400, 100)
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
//        gameOverLabel.text = "Game Over"
//        gameOverLabel.textColor = UIColor.redColor()
//        gameOverLabel.adjustsFontSizeToFitWidth = true
//        gameOverLabel.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) * 0.25)
//        gameOverLabel.textAlignment = .Center
        
        scoreLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 100)
        scoreLabel.text = "Lifetime Score"
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.textAlignment = .Center
        scoreLabel.center.x = screenRect.midX
        scoreLabel.center.y = screenRect.midY
        
        lifetimeScore.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect) + 30, 200, 100)
        lifetimeScore.text = lifetimeScoreAmt.description
        lifetimeScore.textColor = UIColor.blueColor()
        lifetimeScore.adjustsFontSizeToFitWidth = true
        lifetimeScore.textAlignment = .Center
        lifetimeScore.center.x = screenRect.midX
        //        lifetimeScore.center.y = screenRect.midY
        
        self.addSubview(gameOverLabel)
        self.addSubview(scoreLabel)
        self.addSubview(lifetimeScore)
    }
}
