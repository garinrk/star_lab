//
//  OptionsViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/18/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class OptionsViewController : UIViewController{
    //difficulty, fx and music level
    var musicSlider = UISlider()
    var fxSlider = UISlider()
    
    var optionsView = OptionsView()
    
    override func viewDidLoad() {
        optionsView.frame = UIScreen.mainScreen().bounds
        optionsView.backgroundColor = UIColor.brownColor()
        
        self.view.addSubview(optionsView)
    }
    
}
