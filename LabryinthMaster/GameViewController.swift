//
//  GameViewController.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController : UIViewController, GyroDelegate, EnemyViewDelegate, PlayerDelegate {
    let screenRect = UIScreen.mainScreen().bounds
    var gyroManager : Gyro?
    
    var mazeView: MazeView!
    var gameManager: GameManager!
    
    override func loadView() {
        super.loadView()
        
        gameManager = GameManager()
        
        // initialize maze view
        
        mazeView = MazeView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
        for cell in gameManager.maze.cells {
            mazeView.addCellNorth(cell.north, East: cell.east, South: cell.south, West: cell.west, AtX: cell.x, Y: cell.y)
        }

        // add subviews

        view.addSubview(mazeView)
        view.addSubview(gameManager.player)

        for enemy in gameManager.enemies {
            view.addSubview(enemy)
            enemy.delegate = self
        }

        // start the game
        
        gameManager.startGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize and start gyro control
        
        gyroManager = Gyro()
        gyroManager?.delegate = self
        gyroManager?.Start()
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
        gameManager.player.moveX(magX, Y: magY)
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
    
    func detectCollisionFromEnemy(square: CGRect) -> Collision?
    {
        return mazeView.detectCollisionWithRect(square)
    }
    
    // MARK: PlayerDelegate functions
    func detectCollisionFromPlayer(square: CGRect) -> Collision?
    {
        return mazeView.detectCollisionWithRect(square)
    }
}
