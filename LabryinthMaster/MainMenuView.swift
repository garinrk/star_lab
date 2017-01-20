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
    
//    var MainLabel = UILabel()
    var newGameButton = UIButton(type: UIButtonType.custom)
    var optionsButton = UIButton(type: UIButtonType.custom)
    var scoresButton = UIButton(type: UIButtonType.custom)
    
    var titleImage = UIImage(named: "title_logo.png")
    var titleImageBackground = UIImageView(frame: CGRect.zero)
    
    var authorsImage = UIImage(named: "authors.png")
    var authorsImageBackground = UIImageView(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        MainLabel.text = "Star Labyrinth"
//        MainLabel.font = UIFont.systemFontOfSize(35)
//        MainLabel.textColor = UIColor(white: 1, alpha: 0.5)
//        MainLabel.textAlignment = .Center
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false

        authorsImageBackground.image = authorsImage
        self.addSubview(authorsImageBackground)
        authorsImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        newGameButton.setTitle("New Game", for: UIControlState())
        newGameButton.setTitleColor(UIColor.white, for: UIControlState())
        newGameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        newGameButton.layer.borderWidth = 5
        newGameButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        newGameButton.layer.cornerRadius = 5
        newGameButton.layer.borderColor = UIColor.white.cgColor
        self.addSubview(newGameButton)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false

        optionsButton.setTitle("Options",for: UIControlState())
        optionsButton.setTitleColor(UIColor.white, for: UIControlState())
        optionsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        optionsButton.layer.borderWidth = 5
        optionsButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        optionsButton.layer.cornerRadius = 5
        optionsButton.layer.borderColor = UIColor.white.cgColor
        self.addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        scoresButton.setTitle("High Scores", for: UIControlState())
        scoresButton.setTitleColor(UIColor.white, for: UIControlState())
        scoresButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        scoresButton.layer.borderWidth = 5
        scoresButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        scoresButton.layer.cornerRadius = 5
        scoresButton.layer.borderColor = UIColor.white.cgColor
        self.addSubview(scoresButton)
        scoresButton.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:UIView] = ["main":titleImageBackground, "authors":authorsImageBackground, "newGame":newGameButton, "options":optionsButton, "scores":scoresButton]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[main]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[authors]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[newGame]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[scores]-[options(==scores)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[main]-[authors]-100-[newGame]-80-[scores(==newGame)]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[main]-[authors]-100-[newGame]-80-[options(==newGame)]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))

        addConstraint(NSLayoutConstraint(item: newGameButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: newGameButton, attribute: NSLayoutAttribute.width, multiplier: 0.2, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.height, multiplier: 7.2, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: authorsImageBackground, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: authorsImageBackground, attribute: NSLayoutAttribute.height, multiplier: 13.7, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        
    }
}
