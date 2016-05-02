//
//  HighScoreView.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class HighScoreView : UIView{
    var _scoreManager : ScoreManager = ScoreManager.sharedInstance
    
    var backButton = UIButton(type: UIButtonType.Custom)
    var titleImage = UIImage(named: "highscores.png")
    var titleImageBackground = UIImageView(frame: CGRectZero)
    
    var highScore1 = UILabel()
    var highScore2 = UILabel()
    var highScore3 = UILabel()
    var highScore4 = UILabel()
    var highScore5 = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        
//        titleImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.layer.borderWidth = 5
        backButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderColor = UIColor.whiteColor().CGColor
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        //load scores
        _scoreManager.loadScores()
        var entry: ScoreInfo? = nil
        
        highScore1.text = ""
        highScore1.font = UIFont.systemFontOfSize(35)
        highScore1.adjustsFontSizeToFitWidth = true
        highScore1.textColor = UIColor.whiteColor()
        highScore1.textAlignment = .Center
        if _scoreManager.scores.count > 0
        {
            entry = _scoreManager.scores[0]
            if (entry != nil)
            {
                highScore1.text = "1. \(entry!.name)\t-\(entry!.score)-\t\(entry!.difficulty)"
            }
        }
        addSubview(highScore1)
        highScore1.translatesAutoresizingMaskIntoConstraints = false
        
        highScore2.text = ""
        highScore2.font = UIFont.systemFontOfSize(35)
        highScore2.adjustsFontSizeToFitWidth = true
        highScore2.textColor = UIColor.whiteColor()
        highScore2.textAlignment = .Center
        if _scoreManager.scores.count > 1 {
            entry = _scoreManager.scores[1]
            if (entry != nil)
            {
                highScore2.text = "2. \(entry!.name)\t-\(entry!.score)-\t\(entry!.difficulty)"
            }
        }
        addSubview(highScore2)
        highScore2.translatesAutoresizingMaskIntoConstraints = false
        
        highScore3.text = ""
        highScore3.font = UIFont.systemFontOfSize(35)
        highScore3.adjustsFontSizeToFitWidth = true
        highScore3.textColor = UIColor.whiteColor()
        highScore3.textAlignment = .Center
        if _scoreManager.scores.count > 2 {
            entry = _scoreManager.scores[2]
            if (entry != nil)
            {
                highScore3.text = "3. \(entry!.name)\t-\(entry!.score)-\t\(entry!.difficulty)"
            }
        }
        addSubview(highScore3)
        highScore3.translatesAutoresizingMaskIntoConstraints = false
        
        highScore4.text = ""
        highScore4.font = UIFont.systemFontOfSize(35)
        highScore4.adjustsFontSizeToFitWidth = true
        highScore4.textColor = UIColor.whiteColor()
        highScore4.textAlignment = .Center
        if _scoreManager.scores.count > 3 {
            entry = _scoreManager.scores[3]
            if (entry != nil)
            {
                highScore4.text = "4. \(entry!.name)\t-\(entry!.score)-\t\(entry!.difficulty)"
            }
        }
        addSubview(highScore4)
        highScore4.translatesAutoresizingMaskIntoConstraints = false
        
        highScore5.text = ""
        highScore5.font = UIFont.systemFontOfSize(35)
        highScore5.adjustsFontSizeToFitWidth = true
        highScore5.textColor = UIColor.whiteColor()
        highScore5.textAlignment = .Center
        if _scoreManager.scores.count > 4 {
            entry = _scoreManager.scores[4]
            if (entry != nil)
            {
                highScore5.text = "5. \(entry!.name)\t-\(entry!.score)-\t\(entry!.difficulty)"
            }
        }
        addSubview(highScore5)
        highScore5.translatesAutoresizingMaskIntoConstraints = false
        
        
        let views: [String:UIView] = ["title":titleImageBackground, "back":backButton, "score1":highScore1, "score2":highScore2, "score3":highScore3, "score4":highScore4, "score5":highScore5]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[title]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[score1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[score2]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[score3]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[score4]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[score5]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[back]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[title]-[score1][score2(==score1)][score3(==score1)][score4(==score1)][score5(==score1)]-[back(<=100,>=50)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 3.5, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
