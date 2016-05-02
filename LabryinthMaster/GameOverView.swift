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
    
    var lifetimeScoreImage = UIImage(named: "lifetimescore.png")
    var lifetimeScoreImageBackground = UIImageView(frame: CGRectZero)
    
    override func drawRect(rect: CGRect) {
        
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        lifetimeScoreImageBackground.image = lifetimeScoreImage
        self.addSubview(lifetimeScoreImageBackground)
        lifetimeScoreImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        
        lifetimeScore.text = lifetimeScoreAmt.description
        lifetimeScore.textColor = UIColor.redColor()
        lifetimeScore.font = UIFont.systemFontOfSize(30)
        lifetimeScore.textAlignment = .Center
        self.addSubview(lifetimeScore)
        lifetimeScore.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:UIView] = ["main":titleImageBackground, "scoreImage":lifetimeScoreImageBackground, "score":lifetimeScore]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[main]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[scoreImage]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[main]-80-[scoreImage]-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.Width, multiplier: 0.2, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: lifetimeScoreImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: lifetimeScoreImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 7.2, constant: 0.0))
//        addConstraint(NSLayoutConstraint(item: lifetimeScore, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: lifetimeScore, attribute: NSLayoutAttribute.Height, multiplier: 5, constant: 0.0))
}
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
