//
//  LevelCompleteView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class LevelCompleteView : UIView{
    var completeLabel = UILabel()
    var scoreLabel = UILabel()
    var lifetimeScore = UILabel()
    var screenRect = UIScreen.mainScreen().bounds
    var lifetimeScoreAmt : Int = 0

    var titleImage = UIImage(named: "missioncomplete.png")
    var titleImageBackground = UIImageView(frame: CGRectZero)
    
    var currentScoreImage = UIImage(named: "lifetimescore.png")
    var currentScoreImageBackground = UIImageView(frame: CGRectZero)
    
    override func drawRect(rect: CGRect) {

        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        currentScoreImageBackground.image = currentScoreImage
        self.addSubview(currentScoreImageBackground)
        currentScoreImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        lifetimeScore.text = lifetimeScoreAmt.description
        lifetimeScore.adjustsFontSizeToFitWidth = true
        lifetimeScore.textAlignment = .Center
        lifetimeScore.textColor = UIColor.redColor()
        lifetimeScore.font = UIFont.systemFontOfSize(30)
        lifetimeScore.center.x = screenRect.midX
        self.addSubview(lifetimeScore)
        lifetimeScore.translatesAutoresizingMaskIntoConstraints = false
        
        
        let views: [String:UIView] = ["main":titleImageBackground, "scoreImage":currentScoreImageBackground, "score":lifetimeScore]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[main]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[scoreImage]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[main]-80-[scoreImage]-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.Width, multiplier: 0.2, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: currentScoreImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: currentScoreImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 7.2, constant: 0.0))
        
        
    }
}
