//
//  AppDelegate.swift
//  Movement_Test
//
//  Created by Garin Richards on 4/8/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GameLoopDelegate {

    var window: UIWindow?
    var loop : GameLoop = GameLoop()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       
        let rvc : UIViewController = GyroViewController()
        rvc.view.backgroundColor = UIColor.darkGrayColor()
        
        
        
        loop.delegate = self
        loop.start()
        
        window = UIWindow()
        window!.rootViewController = rvc
        window!.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }
    
    /**
     From the game loop update delegate
     */
    func update() {
//     print("Sup")
    }


}

