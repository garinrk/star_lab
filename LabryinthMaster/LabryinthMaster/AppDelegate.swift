//
//  AppDelegate.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/8/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var shouldAutorotate : Bool {
        return false
    }
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait] //,UIInterfaceOrientationMask.PortraitUpsideDown]
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MainMenuViewControllerDelegate, GameViewControllerDelegate {

    var window: UIWindow?
    let mainNavController = UINavigationController()
    let mainMenuViewController = MainMenuViewController()
    let gameViewController = GameViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNavController

        mainNavController.setNavigationBarHidden(true, animated: false)
//        mainNavController.pushViewController(mainMenuViewController, animated: false)
        
        
        
        let lcvc = GameOverViewController()
        mainNavController.pushViewController(lcvc, animated: false)

        
        
        mainMenuViewController.delegate = self
        gameViewController.delegate = self
        
//        gameViewController.startNewGame("test", difficulty: .Easy)
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        if mainNavController.topViewController == gameViewController
        {
            gameViewController.PauseGame()
        }
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
//        if mainNavController.topViewController == gameViewController
//        {
//            gameViewController.UnpauseGame()
//        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }

    // MARK: MainMenuViewControllerDelegate functions
    func startNewGame(name: String, difficulty: DifficultyMode) {
        
//        mainNavController.popViewControllerAnimated(false)
//        mainNavController.pushViewController(gameViewController, animated: false)
//        gameViewController.startNewGame(name, difficulty: difficulty)
        
        mainNavController.present(gameViewController, animated: false, completion: {
            () -> Void in
        self.gameViewController.startNewGame(name: name, difficulty: difficulty)
        })
    }
    
    // MARK: GameViewControllerDelegate functions
    func backToMainPressed() {
        mainNavController.dismiss(animated: false, completion: nil)
//        mainNavController.popViewControllerAnimated(false)
//        mainNavController.pushViewController(mainMenuViewController, animated: false)
    }
}

