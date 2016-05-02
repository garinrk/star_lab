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
        optionsTitleLabel.text = "Options Menu"
        optionsTitleLabel.font = UIFont.systemFontOfSize(35)
        optionsTitleLabel.textColor = UIColor.whiteColor()
        optionsTitleLabel.adjustsFontSizeToFitWidth = true
        optionsTitleLabel.center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) * 0.25)
        optionsTitleLabel.textAlignment = .Center
        
        musicLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        musicLabel.text = "Music Level"
        musicLabel.font = UIFont.systemFontOfSize(17)
        musicLabel.textColor = UIColor.whiteColor()
        musicLabel.adjustsFontSizeToFitWidth = true
        musicLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.55)
        musicLabel.textAlignment = .Center
        
        fxLabel.frame = CGRectMake(CGRectGetMidX(rect), CGRectGetMidY(rect), 200, 50)
        fxLabel.text = "Effects Level"
        fxLabel.font = UIFont.systemFontOfSize(17)
        fxLabel.textColor = UIColor.whiteColor()
        fxLabel.adjustsFontSizeToFitWidth = true
        fxLabel.center = CGPointMake(CGRectGetMaxX(self.frame) * 0.30,CGRectGetMaxY(self.frame) * 0.60)
        fxLabel.textAlignment = .Center
        
        
        self.addSubview(musicLabel)
        self.addSubview(fxLabel)
        self.addSubview(optionsTitleLabel)
    }

}
