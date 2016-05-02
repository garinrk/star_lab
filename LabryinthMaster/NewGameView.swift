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
    
    override func drawRect(rect: CGRect) {
        
        newSessionLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        newSessionLabel.text = "New Session"
        newSessionLabel.adjustsFontSizeToFitWidth = true
        newSessionLabel.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) * 0.25)
        newSessionLabel.textAlignment = .Center
        
        diffLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        diffLabel.text = "Difficulty"
        diffLabel.adjustsFontSizeToFitWidth = true
        diffLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.70)
        diffLabel.textAlignment = .Center
        
        playerNameLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 100)
        playerNameLabel.text = "Player Name"
        playerNameLabel.adjustsFontSizeToFitWidth = true
        //        playerNameLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.70)
        playerNameLabel.textAlignment = .Center
        playerNameLabel.center.x = screenRect.midX
        playerNameLabel.center.y = screenRect.midY
        
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.backgroundColor = UIColor.grayColor()
        
        startButton.setTitle("Start Game",forState: UIControlState.Normal)
        startButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)
        startButton.backgroundColor = UIColor.redColor()
        
        easyButton.setTitle("Easy", forState: UIControlState.Normal)
        easyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        easyButton.backgroundColor = UIColor.darkGrayColor()

        hardButton.setTitle("Hard", forState: UIControlState.Normal)
        hardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        hardButton.backgroundColor = UIColor.darkGrayColor()
        
        gameNameTextEntry.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height * 0.5 + 40, 150, 40)
        gameNameTextEntry.textAlignment = NSTextAlignment.Center
        gameNameTextEntry.font = UIFont.systemFontOfSize(15)
        gameNameTextEntry.textColor = UIColor.blackColor()
        gameNameTextEntry.borderStyle = UITextBorderStyle.RoundedRect
        gameNameTextEntry.autocorrectionType = UITextAutocorrectionType.No
        gameNameTextEntry.keyboardType = UIKeyboardType.Default
        gameNameTextEntry.returnKeyType = UIReturnKeyType.Done
        gameNameTextEntry.clearButtonMode = UITextFieldViewMode.WhileEditing;
        gameNameTextEntry.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        gameNameTextEntry.center.x = screenRect.midX
        gameNameTextEntry.center.y = screenRect.midY + 40

        
        
        
        
        addSubview(diffLabel)
        addSubview(playerNameLabel)
        addSubview(newSessionLabel)
        addSubview(backButton)
        addSubview(easyButton)
        addSubview(hardButton)
        addSubview(startButton)
        addSubview(gameNameTextEntry)
    }
}
