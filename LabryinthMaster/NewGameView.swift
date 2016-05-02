//
//  NewGameView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class NewGameView : UIView{
    
//    var newSessionLabel = UILabel()
    var backButton = UIButton(type: UIButtonType.Custom)
    var easyButton = UIButton(type: UIButtonType.Custom)
    var hardButton = UIButton(type: UIButtonType.Custom)
    var startButton = UIButton(type: UIButtonType.Custom)
    var gameNameTextEntry = UITextField(frame: CGRectZero)
    
    var titleImage = UIImage(named: "newmission.png")
    var titleImageBackground = UIImageView(frame: CGRectZero)
    var screenRect = UIScreen.mainScreen().bounds
    
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
        
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.backgroundColor = UIColor.darkGrayColor()
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.setTitle("Start Game", forState: UIControlState.Normal)
        startButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)
        startButton.backgroundColor = UIColor.redColor()
        addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        easyButton.setTitle("Easy", forState: UIControlState.Normal)
        easyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        easyButton.backgroundColor = UIColor.darkGrayColor()
        addSubview(easyButton)
        easyButton.translatesAutoresizingMaskIntoConstraints = false
        
        hardButton.setTitle("Hard", forState: UIControlState.Normal)
        hardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        hardButton.backgroundColor = UIColor.darkGrayColor()
        addSubview(hardButton)
        hardButton.translatesAutoresizingMaskIntoConstraints = false
        
        gameNameTextEntry.textAlignment = NSTextAlignment.Center
        gameNameTextEntry.font = UIFont.systemFontOfSize(15)
        gameNameTextEntry.text = "ENTER NAME HERE"
        gameNameTextEntry.textColor = UIColor.blackColor()
        gameNameTextEntry.borderStyle = UITextBorderStyle.RoundedRect
        gameNameTextEntry.autocorrectionType = UITextAutocorrectionType.No
        gameNameTextEntry.keyboardType = UIKeyboardType.Default
        gameNameTextEntry.returnKeyType = UIReturnKeyType.Done
        gameNameTextEntry.clearButtonMode = UITextFieldViewMode.WhileEditing;
        gameNameTextEntry.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        addSubview(gameNameTextEntry)
        gameNameTextEntry.translatesAutoresizingMaskIntoConstraints = false

        let views: [String:UIView] = ["newSession":titleImageBackground, "back":backButton, "easy":easyButton, "hard":hardButton, "start":startButton, "text": gameNameTextEntry]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[back]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[newSession]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[text]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[easy]-[hard(==easy)]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[start]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))

        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[back(<=40)][newSession][text]-20-[easy]-80-[start(==easy)]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[newSession][text]-20-[hard]-80-[start(==easy)]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: gameNameTextEntry, attribute: NSLayoutAttribute.Height, multiplier: 1.75, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 7.2, constant: 0.0))
//        addConstraint(NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: startButton, attribute: NSLayoutAttribute.Width, multiplier: 0.75, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
