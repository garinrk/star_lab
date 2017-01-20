//
//  NewGameView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class NewGameView : UIView, UITextFieldDelegate {
    
//    var newSessionLabel = UILabel()
    var backButton = UIButton(type: UIButtonType.custom)
    var easyButton = UIButton(type: UIButtonType.custom)
    var hardButton = UIButton(type: UIButtonType.custom)
    var startButton = UIButton(type: UIButtonType.custom)
    var gameNameTextEntry = UITextField(frame: CGRect.zero)
    
    var titleImage = UIImage(named: "newmission.png")
    var titleImageBackground = UIImageView(frame: CGRect.zero)
    var screenRect = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        newSessionLabel.text = "New Mission"
//        newSessionLabel.textAlignment = .Center
//        newSessionLabel.font = UIFont.systemFontOfSize(35)
//        titleImageBackground.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        titleImageBackground.image = titleImage
        self.addSubview(titleImageBackground)
        addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setTitle("Back", for: UIControlState())
        backButton.setTitleColor(UIColor.white, for: UIControlState())
        backButton.layer.borderWidth = 5
        backButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderColor = UIColor.white.cgColor
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.setTitle("Start Game", for: UIControlState())
        startButton.setTitleColor(UIColor.white, for: UIControlState.disabled)
        startButton.layer.borderWidth = 5
        startButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        startButton.layer.cornerRadius = 5
        startButton.layer.borderColor = UIColor.white.cgColor
        addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        easyButton.setTitle("Easy", for: UIControlState())
        easyButton.setTitleColor(UIColor.white, for: UIControlState())
        easyButton.layer.borderWidth = 5
        easyButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        easyButton.layer.cornerRadius = 5
        easyButton.layer.borderColor = UIColor.white.cgColor
        addSubview(easyButton)
        easyButton.translatesAutoresizingMaskIntoConstraints = false
        
        hardButton.setTitle("Hard", for: UIControlState())
        hardButton.setTitleColor(UIColor.white, for: UIControlState())
        hardButton.layer.borderWidth = 5
        hardButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        hardButton.layer.cornerRadius = 5
        hardButton.layer.borderColor = UIColor.white.cgColor
        addSubview(hardButton)
        hardButton.translatesAutoresizingMaskIntoConstraints = false
        
        gameNameTextEntry.textAlignment = NSTextAlignment.center
        gameNameTextEntry.font = UIFont.systemFont(ofSize: 15)
        gameNameTextEntry.text = "ENTER NAME HERE"
        gameNameTextEntry.delegate = self
        gameNameTextEntry.textColor = UIColor.black
        gameNameTextEntry.borderStyle = UITextBorderStyle.roundedRect
        gameNameTextEntry.autocorrectionType = UITextAutocorrectionType.no
        gameNameTextEntry.keyboardType = UIKeyboardType.default
        gameNameTextEntry.returnKeyType = UIReturnKeyType.done
        gameNameTextEntry.clearButtonMode = UITextFieldViewMode.whileEditing;
        gameNameTextEntry.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        addSubview(gameNameTextEntry)
        gameNameTextEntry.translatesAutoresizingMaskIntoConstraints = false

        let spacer: UIView = UIView()
        addSubview(spacer)
        spacer.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:UIView] = ["newSession":titleImageBackground, "back":backButton, "easy":easyButton, "hard":hardButton, "start":startButton, "text": gameNameTextEntry, "spacer":spacer]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[back]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[spacer]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[newSession]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[text]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[easy]-[hard(==easy)]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[start]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[back(<=40)][spacer(==150)][newSession]-(>=50)-[text]-20-[easy]-100-[start(==easy)]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(80)-[spacer(==150)][newSession]-(>=50)-[text]-20-[hard(==easy)]-100-[start(==easy)]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.height, multiplier: 0.7, constant: 0.0))

        addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: gameNameTextEntry, attribute: NSLayoutAttribute.height, multiplier: 1.75, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.height, multiplier: 7.2, constant: 0.0))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
