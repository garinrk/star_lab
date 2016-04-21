//
//  OptionsView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/18/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class OptionsView : UIView{
    var optionsTitleLabel = UILabel()
    var diffLabel = UILabel()
    var musicLabel = UILabel()
    var fxLabel = UILabel()

    
    var screenRect = UIScreen.mainScreen().bounds
    
    override func drawRect(rect: CGRect) {
        
        optionsTitleLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
//        optionsTitleLabel.frame.width = 200.0
        
        optionsTitleLabel.text = "Options Menu"
        optionsTitleLabel.adjustsFontSizeToFitWidth = true
        optionsTitleLabel.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) * 0.25)
        optionsTitleLabel.textAlignment = .Center
        
        diffLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        diffLabel.text = "Difficulty"
        diffLabel.adjustsFontSizeToFitWidth = true
        diffLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.45)
        diffLabel.textAlignment = .Center
        
        musicLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        musicLabel.text = "Music Level"
        musicLabel.adjustsFontSizeToFitWidth = true
        musicLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.55)
        musicLabel.textAlignment = .Center
        
        fxLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        fxLabel.text = "Effects Level"
        fxLabel.adjustsFontSizeToFitWidth = true
        fxLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.60)
        fxLabel.textAlignment = .Center
        
        
        self.addSubview(musicLabel)
        self.addSubview(fxLabel)
        self.addSubview(diffLabel)
        self.addSubview(optionsTitleLabel)
    }
    
    func BackButtonPressed(){
        print ("Back pressed, set up delegate!")
//        self.
//        self.navigationController?.popViewControllerAnimated(true)
    }
}
