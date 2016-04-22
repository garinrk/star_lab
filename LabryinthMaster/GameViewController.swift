//
//  GameViewController.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController : UIViewController, GyroDelegate, GameLoopDelegate, EnemyViewDelegate{
    var screenRect = UIScreen.mainScreen().bounds
    var gyroManager : Gyro?
    var gyroView : GyroView?
    var globalPlayerX : CGFloat = 50.0
    var globalPlayerY : CGFloat = 50.0
    
    var mazeView: MazeView!
    
    var tempEnemyView: EnemyView!
    var tempEnemyView2: EnemyView!
    var tempEnemyView3: EnemyView!
    var tempEnemyView4: EnemyView!
    
    let gameManager: GameManager = GameManager()
    
    override func loadView() {
        super.loadView()
        
        mazeView = MazeView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
        
        for cell in gameManager.maze.cells {
            mazeView.addCellNorth(cell.north, East: cell.east, South: cell.south, West: cell.west, AtX: cell.x, Y: cell.y)
        }
        
        view.addSubview(mazeView)
        
        tempEnemyView = EnemyView(frame: mazeView.frame)
        view.addSubview(tempEnemyView)
        
        tempEnemyView2 = EnemyView(frame: mazeView.frame)
        view.addSubview(tempEnemyView2)
        
        tempEnemyView3 = EnemyView(frame: mazeView.frame)
        view.addSubview(tempEnemyView3)
        
        tempEnemyView4 = EnemyView(frame: mazeView.frame)
        view.addSubview(tempEnemyView4)
        
        gameManager.gameLoop.delegate = self
        gameManager.gameLoop.start()
        
        tempEnemyView.delegate = self
        tempEnemyView.start()
        
        tempEnemyView2.delegate = self
        tempEnemyView2.start()
        
        tempEnemyView3.delegate = self
        tempEnemyView3.start()
        
        tempEnemyView4.delegate = self
        tempEnemyView4.start()

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gyroManager = Gyro()
        gyroManager?.delegate = self
        gyroManager?.Start()
        
        gyroView = GyroView()
        gyroView!.frame = screenRect
        
        gyroView!.backgroundColor = UIColor(white: 1, alpha: 0)
        self.view.addSubview(gyroView!)
        
    }
    
    // MARK: GyroDelegate functions
    
    /**
     Updates the player's position on the view, from the
     GyroDelegate
     
     - parameter x: magnitude in x
     - parameter y: magnitude in y
     */
    func UpdatePlayerPosition(magX: CGFloat, magY: CGFloat)
    {
        
        //What is the player's current x and y values
        let currentX = globalPlayerX
        let currentY = globalPlayerY
        
        
        //create a new player
        let newPlayer = PlayerCell()
        newPlayer.tag = 99 //give it a tag that we will use to remove it later
        
        //calculate a new x and y based on the magnitudes
        let newX = currentX + magX * 40
        let newY = currentY - magY * 40
        
        //Set's the player's position in the view
        newPlayer.frame = CGRectMake(newX, newY, 25, 25)
        newPlayer.backgroundColor = UIColor.blueColor()
        
        //remove the old player
        for view in self.gyroView!.subviews{
            if view.tag == 99{
                view.removeFromSuperview()
            }
        }
        
        //add to view
        self.gyroView!.addSubview(newPlayer)
        
        //save the new player's position
        globalPlayerX = newX
        globalPlayerY = newY
    }
    
    // MARK: GameLoopDelegate functions
    
    func update() {
        tempEnemyView.update()
        tempEnemyView2.update()
        tempEnemyView3.update()
        tempEnemyView4.update()
        
    }
    
    // MARK: EnemyViewDelegate functions
    func getMazeDimension() -> Int
    {
        return gameManager.maze.dimension
    }
    
    func getMazeCellPosX(x: Int, Y y: Int) -> CGPoint
    {
        return mazeView.getCellPosX(x, Y: y)
    }
    
    func detectCollisionFromEnemy(square: CGRect) -> Bool
    {
        return mazeView.detectCollisionWithRect(square)
    }
}
