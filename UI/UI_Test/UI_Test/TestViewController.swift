//
//  TestViewController.swift
//  UI_Test
//
//  Created by Garin Richards on 4/17/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class TestViewController : UIViewController{
    
    var testView = TestView()
    
    override func viewDidLoad() {
        testView.frame = UIScreen.mainScreen().bounds
        testView.backgroundColor = UIColor.brownColor()
        self.view.addSubview(testView)
        
    }
}
