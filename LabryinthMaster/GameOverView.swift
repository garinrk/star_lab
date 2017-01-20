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
    var screenRect = UIScreen.main.bounds
    var _gameManager : GameManager = GameManager.sharedInstance
    
    var lifetimeScoreAmt: Int = 0
    
    var titleImage = UIImage(named: "gameover.png")
    var titleImageBackground = UIImageView(frame: CGRect.zero)
    
    var lifetimeScoreImage = UIImage(named: "lifetimescore.png")
    var lifetimeScoreImageBackground = UIImageView(frame: CGRect.zero)
    
    override func draw(_ rect: CGRect) {
        
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        lifetimeScoreImageBackground.image = lifetimeScoreImage
        self.addSubview(lifetimeScoreImageBackground)
        lifetimeScoreImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        
        lifetimeScore.text = lifetimeScoreAmt.description
        lifetimeScore.textColor = UIColor.red
        lifetimeScore.font = UIFont.systemFont(ofSize: 30)
        lifetimeScore.textAlignment = .center
        self.addSubview(lifetimeScore)
        lifetimeScore.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:UIView] = ["main":titleImageBackground, "scoreImage":lifetimeScoreImageBackground, "score":lifetimeScore]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[main]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[scoreImage]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[main]-80-[scoreImage]-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.width, multiplier: 0.2, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: lifetimeScoreImageBackground, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: lifetimeScoreImageBackground, attribute: NSLayoutAttribute.height, multiplier: 7.2, constant: 0.0))
//        addConstraint(NSLayoutConstraint(item: lifetimeScore, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: lifetimeScore, attribute: NSLayoutAttribute.Height, multiplier: 5, constant: 0.0))
}
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
