//
//  NewGameView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class NewGameView : UIView{
    
    var newSessionLabel = UILabel()
    var diffLabel = UILabel()
    var playerNameLabel = UILabel()
    var backButton = UIButton(type: UIButtonType.Custom)
    var easyButton = UIButton(type: UIButtonType.Custom)
    var hardButton = UIButton(type: UIButtonType.Custom)
    var startButton = UIButton(type: UIButtonType.Custom)
    var gameNameTextEntry = UITextField(frame: CGRectZero)
    
    
    var screenRect = UIScreen.mainScreen().bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newSessionLabel.text = "New Mission"
        newSessionLabel.textAlignment = .Center
        newSessionLabel.font = UIFont.systemFontOfSize(35)
        addSubview(newSessionLabel)
        newSessionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        diffLabel.text = "Difficulty:"
        diffLabel.textAlignment = .Center
        diffLabel.font = UIFont.systemFontOfSize(15)
        addSubview(diffLabel)
        diffLabel.translatesAutoresizingMaskIntoConstraints = false
        
        playerNameLabel.text = "Player Name:"
        playerNameLabel.textAlignment = .Center
        playerNameLabel.font = UIFont.systemFontOfSize(15)
        addSubview(playerNameLabel)
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backBut∑ton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.backgroundColor = UIColor.orangeColor()
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.setTitle("Start Game",forState: UIControlState.Normal)
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

        let views: [String:UIView] = ["newSession":newSessionLabel, "diff":diffLabel, "name":playerNameLabel, "back":backButton, "easy":easyButton, "hard":hardButton, "start":startButton, "text": gameNameTextEntry]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[back]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[newSession]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[name]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[text]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[diff]-80-[easy]-[hard(==easy)]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[start]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[back][newSession][name][text]-40-[diff]-80-[start]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[back][newSession][name][text]-40-[diff(==name)]-80-[start(==name)]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[newSession][name][text]-40-[easy(==name)]-80-[start(==name)]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[newSession][name][text]-40-[hard(==name)]-80-[start(==name)]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: playerNameLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: gameNameTextEntry, attribute: NSLayoutAttribute.Height, multiplier: 1.75, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
