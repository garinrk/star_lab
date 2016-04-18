//
//  AppDelegate.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/8/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GameLoopDelegate, EnemyViewDelegate {

    var window: UIWindow?
    
    let gameLoop: GameLoop = GameLoop()
    let maze: Maze = Maze()
    let tempViewController: UIViewController = UIViewController()
    
    var mazeView: MazeView!
    
    var tempEnemyView: EnemyView!
    var tempEnemyView2: EnemyView!
    var tempEnemyView3: EnemyView!
    var tempEnemyView4: EnemyView!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = tempViewController

        tempViewController.view.backgroundColor = UIColor.yellowColor()
        
        
        mazeView = MazeView(frame: CGRect(x: 0, y: 50.0, width: window!.frame.width, height: window!.frame.width))
        
        for cell in maze.cells {
            mazeView.addCellNorth(cell.north, East: cell.east, South: cell.south, West: cell.west, AtX: cell.x, Y: cell.y)
        }
        
        tempViewController.view.addSubview(mazeView)
        
        tempEnemyView = EnemyView(frame: mazeView.frame)
        tempViewController.view.addSubview(tempEnemyView)

        tempEnemyView2 = EnemyView(frame: mazeView.frame)
        tempViewController.view.addSubview(tempEnemyView2)

        tempEnemyView3 = EnemyView(frame: mazeView.frame)
        tempViewController.view.addSubview(tempEnemyView3)

        tempEnemyView4 = EnemyView(frame: mazeView.frame)
        tempViewController.view.addSubview(tempEnemyView4)
        
        gameLoop.delegate = self
        gameLoop.start()
        
        tempEnemyView.delegate = self
        tempEnemyView.start()
        
        tempEnemyView2.delegate = self
        tempEnemyView2.start()
        
        tempEnemyView3.delegate = self
        tempEnemyView3.start()
        
        tempEnemyView4.delegate = self
        tempEnemyView4.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func update() {
        tempEnemyView.update()
        tempEnemyView2.update()
        tempEnemyView3.update()
        tempEnemyView4.update()

    }
    

    
    
    
    // MARK: EnemyViewDelegate functions
    func getMazeDimension() -> Int
    {
        return maze.dimension
    }
    
    func getMazeCellCenterX(x: Int, Y y: Int) -> CGPoint
    {
        return mazeView.getCellCenterX(x, Y: y)
    }
    
    func detectCollisionFromEnemy(square: CGRect) -> Bool
    {
        return mazeView.detectCollisionWithRect(square)        
    }
    
//    func detectCenteredInCell(square: CGRect)
//    {
//        if mazeView.detectCenteredInCell(square)
//        {
//            tempEnemyView.centered = true
//        }
//    }
    
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        gameLoop.stop()
    }


}

