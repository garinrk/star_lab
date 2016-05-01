//
//  AppDelegate.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/8/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

extension UINavigationController {
    public override func shouldAutorotate() -> Bool {
        return false
    }
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait] //,UIInterfaceOrientationMask.PortraitUpsideDown]
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MainMenuViewControllerDelegate, GameViewControllerDelegate {

    var window: UIWindow?
    let mainNavController = UINavigationController()
    let mainMenuViewController = MainMenuViewController()
    let gameViewController = GameViewController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = mainNavController

        mainNavController.setNavigationBarHidden(true, animated: false)
        mainNavController.pushViewController(mainMenuViewController, animated: false)
        
        mainMenuViewController.delegate = self
        gameViewController.delegate = self
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        if mainNavController.topViewController == gameViewController
        {
            gameViewController.PauseGame()
        }
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if mainNavController.topViewController == gameViewController
        {
            gameViewController.UnpauseGame()
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }

    // MARK: MainMenuViewControllerDelegate functions
    func startNewGame(name: String, difficulty: DifficultyMode) {
        mainNavController.pushViewController(gameViewController, animated: false)
        gameViewController.startNewGame(name, difficulty: difficulty)
    }
    
    // MARK: GameViewControllerDelegate functions
    
}

