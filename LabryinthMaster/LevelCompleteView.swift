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
    var screenRect = UIScreen.main.bounds
    var lifetimeScoreAmt : Int = 0

    var titleImage = UIImage(named: "missioncomplete.png")
    var titleImageBackground = UIImageView(frame: CGRect.zero)
    
    var currentScoreImage = UIImage(named: "lifetimescore.png")
    var currentScoreImageBackground = UIImageView(frame: CGRect.zero)
    
    override func draw(_ rect: CGRect) {

        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        currentScoreImageBackground.image = currentScoreImage
        self.addSubview(currentScoreImageBackground)
        currentScoreImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        lifetimeScore.text = lifetimeScoreAmt.description
        lifetimeScore.adjustsFontSizeToFitWidth = true
        lifetimeScore.textAlignment = .center
        lifetimeScore.textColor = UIColor.red
        lifetimeScore.font = UIFont.systemFont(ofSize: 30)
        lifetimeScore.center.x = screenRect.midX
        self.addSubview(lifetimeScore)
        lifetimeScore.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:UIView] = ["main":titleImageBackground, "scoreImage":currentScoreImageBackground, "score":lifetimeScore]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[main]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[scoreImage]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[main]-80-[scoreImage]-[score]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.width, multiplier: 0.2, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: currentScoreImageBackground, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: currentScoreImageBackground, attribute: NSLayoutAttribute.height, multiplier: 7.2, constant: 0.0))
    }
}
