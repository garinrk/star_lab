//
//  TestView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/17/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class TestView : UIView{
    var mainTitle = UILabel()
    

    override func drawRect(rect: CGRect) {
        mainTitle.text = "Check this out"
        mainTitle.frame = CGRectMake(UIScreen.mainScreen().bounds.width * 0.25, UIScreen.mainScreen().bounds.height * 0.25,500, 20)
        mainTitle.adjustsFontSizeToFitWidth = true
        
        self.addSubview(mainTitle)
    }
}
