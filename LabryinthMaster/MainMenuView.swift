//
//  MainMenuView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/17/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

/// New, load, high scores, options
class MainMenuView : UIView{
    
    var MainLabel = UILabel()
    var newGameButton = UIButton(type: UIButtonType.Custom)
    var optionsButton = UIButton(type: UIButtonType.Custom)
    var scoresButton = UIButton(type: UIButtonType.Custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        MainLabel.text = "Star Labyrinth"
        MainLabel.font = UIFont.systemFontOfSize(35)
        MainLabel.textColor = UIColor(white: 1, alpha: 0.5)
        MainLabel.textAlignment = .Center
        self.addSubview(MainLabel)
        MainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newGameButton.setTitle("New Game", forState: UIControlState.Normal)
        newGameButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        newGameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        newGameButton.layer.borderWidth = 5
        newGameButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        newGameButton.layer.cornerRadius = 5
        newGameButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.addSubview(newGameButton)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false

        optionsButton.setTitle("Options",forState: UIControlState.Normal)
        optionsButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        optionsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        optionsButton.layer.borderWidth = 5
        optionsButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        optionsButton.layer.cornerRadius = 5
        optionsButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        scoresButton.setTitle("High Scores", forState: UIControlState.Normal)
        scoresButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        scoresButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        scoresButton.layer.borderWidth = 5
        scoresButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        scoresButton.layer.cornerRadius = 5
        scoresButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.addSubview(scoresButton)
        scoresButton.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:UIView] = ["main":MainLabel, "newGame":newGameButton, "options":optionsButton, "scores":scoresButton]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[main]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[newGame]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[scores]-[options(==scores)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))

        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[main][newGame]-80-[scores(==newGame)]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[main][newGame]-80-[options(==newGame)]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))

        addConstraint(NSLayoutConstraint(item: newGameButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: newGameButton, attribute: NSLayoutAttribute.Width, multiplier: 0.2, constant: 0.0))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        

        
        
    }
}
