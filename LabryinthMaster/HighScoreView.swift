//
//  HighScoreView.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class HighScoreView : UIView{
//    var highScoreLabel = UILabel()
    var _scoreManager : ScoreManager = ScoreManager.sharedInstance
    
    var titleImage = UIImage(named: "highscores.png")
    var titleImageBackground = UIImageView(frame: CGRectZero)
    
    override func drawRect(rect: CGRect) {
//        highScoreLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
//        highScoreLabel.font = UIFont.systemFontOfSize(35)
//        highScoreLabel.text = "High Scores"
//        highScoreLabel.textColor = UIColor.whiteColor()
//        highScoreLabel.adjustsFontSizeToFitWidth = true
//        highScoreLabel.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) * 0.25)
//        highScoreLabel.textAlignment = .Center
//        self.addSubview(highScoreLabel)
        
        titleImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        
        //load scores
        _scoreManager.loadScores()
        
        //for only the first five scores
        var placeholder = 1
        
        for entry in _scoreManager.scores{
            if placeholder <= 5{
                
                //create a new label
                let highScoreEntry = UILabel()
                highScoreEntry.frame = CGRectMake(0,100 * CGFloat(placeholder), 200, 50)
                highScoreEntry.text = "\(entry.name)\t\(entry.score)\t\(entry.difficulty)"
                highScoreEntry.font = UIFont.systemFontOfSize(17)
                highScoreEntry.textColor = UIColor.whiteColor()
                
                highScoreEntry.textAlignment = .Center
                placeholder += 1
                
                //add view
                self.addSubview(highScoreEntry)
                
            }
        }
    }
}
