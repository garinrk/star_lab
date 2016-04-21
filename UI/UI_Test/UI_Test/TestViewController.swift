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
    let button1 : UIButton! = UIButton(type: UIButtonType.Custom)
    let button2 : UIButton! = UIButton(type: UIButtonType.Custom)
    let button3 : UIButton! = UIButton(type: UIButtonType.Custom)
    let button4 : UIButton! = UIButton(type: UIButtonType.Custom)
    var mmvc : MainMenuViewController?
    var ovc : OptionsViewController?
    var pvc : PauseViewController?
    var ngvc : NewGameViewController?
    
    override func viewDidLoad() {
        testView.frame = UIScreen.mainScreen().bounds
        testView.backgroundColor = UIColor.brownColor()
        
        
        
//        self.view.addSubview(testView)
        
        //button1
        button1.frame = CGRectMake(50, 100, 500, 50)
        button1.addTarget(self, action: #selector(TestViewController.Button1Pressed), forControlEvents: UIControlEvents.TouchUpInside)
        button1.setTitle("Main Menu", forState: UIControlState.Normal)
        button1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button1.backgroundColor = UIColor.blackColor()
        
        //button2
        button2.frame = CGRectMake(50, 200, 500, 50)
        button2.addTarget(self, action: #selector(TestViewController.Button2Pressed), forControlEvents: UIControlEvents.TouchUpInside)
        button2.setTitle("Options", forState: UIControlState.Normal)
        button2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button2.backgroundColor = UIColor.blackColor()
        
        //button3
        button3.frame = CGRectMake(50, 300, 500, 50)
        button3.addTarget(self, action: #selector(TestViewController.Button3Pressed), forControlEvents: UIControlEvents.TouchUpInside)
        button3.setTitle("Pause", forState: UIControlState.Normal)
        button3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button3.backgroundColor = UIColor.blackColor()
        
        //button4
        button4.frame = CGRectMake(50, 400, 500, 50)
        button4.addTarget(self, action: #selector(TestViewController.Button4Pressed), forControlEvents: UIControlEvents.TouchUpInside)
        button4.setTitle("New Game", forState: UIControlState.Normal)
        button4.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button4.backgroundColor = UIColor.blackColor()
        
//        Button4Pressed()
        self.view.addSubview(testView)
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
       
        
    }
    
    func Button1Pressed(){
        mmvc = MainMenuViewController()
        
        print("Presenting Main Menu")
        self.navigationController?.pushViewController(mmvc!, animated: false)
    }
    
    func Button2Pressed(){
        ovc = OptionsViewController()
        
        
        print("Presenting Options")
        self.navigationController?.pushViewController(ovc!, animated: false)
    }
    
    func Button3Pressed(){
        pvc = PauseViewController()
        
        print("Presenting Pause")
        self.navigationController?.pushViewController(pvc!, animated: false)
    }
    
    func Button4Pressed(){
        ngvc = NewGameViewController()
        
        print("Presenting New Game")
        self.navigationController?.pushViewController(ngvc!, animated: false)
    }
}
