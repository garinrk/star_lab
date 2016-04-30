//
//  GameViewController.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController : UIViewController, GyroDelegate, EnemyViewDelegate, PlayerDelegate, GameManagerDelegate {
    let screenRect = UIScreen.mainScreen().bounds
    var gyroManager : Gyro?
    
    var scoreLabel: UILabel!
    var mazeView: MazeView!
    var gameManager: GameManager!
    var audioManager: AudioManager!
    
    
    override func loadView() {
        super.loadView()
        
        //hide back button and top bar
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.hidden = true
        
        //MANAGERS
        audioManager = AudioManager()
        gameManager = GameManager()
        gameManager.delegate = self
        
        // initialize maze view
        
        mazeView = MazeView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
        for cell in gameManager.maze.cells {
            mazeView.addCellNorth(cell.north, East: cell.east, South: cell.south, West: cell.west, AtX: cell.x, Y: cell.y)
        }
        for _ in 0 ..< gameManager.coinAmt {
            mazeView.placeRandomCoin()
        }

        // add subviews and assign delegates

        view.addSubview(mazeView)
//        mazeView.delegate = self
//        for coin in gameManager.coins {
//            view.addSubview(coin)
//            coin.delegate = self
//        }
        for enemy in gameManager.enemies {
            view.addSubview(enemy)
            enemy.delegate = self
        }
        view.addSubview(gameManager.player)
        gameManager.player.delegate = self

        // start the game
        
        gameManager.startGame()
        
        scoreLabel = UILabel(frame: CGRect(x: 50.0, y: screenRect.width + 75.0, width: screenRect.width, height: 80.0))
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.text = "SCORE: \(gameManager.score)"
        view.addSubview(scoreLabel)
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
        gameManager.currentGyroMagX = magX
        gameManager.currentGyroMagY = magY
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
    
    func getMazeCellAtX(x: Int, Y y: Int) -> MazeViewCell?
    {
        return mazeView.cells["\(x),\(y)"]
    }
    
    func getMazeCellSize() -> CGSize
    {
        return mazeView.getCellSize()
    }
    
    func detectCollisionFromEnemy(square: CGRect) -> Collision
    {
        return mazeView.detectCollisionWithRect(square)
    }
    
    func getPlayerCell() -> MazeViewCell
    {
        return getMazeCellAtX(gameManager.player.cellX, Y: gameManager.player.cellY)!
    }

    func reportPlayerCollision()
    {
        gameManager.kill()
    }

    
    // MARK: PlayerDelegate functions
    func detectCollisionFromPlayer(square: CGRect) -> Collision
    {
        return mazeView.detectCollisionWithRect(square)
    }
    func coinCollected()
    {
        gameManager.coinCollected()
        audioManager.PlayAudio(SoundType.FX1)
        scoreLabel.text = "SCORE: \(gameManager.score)"
    }
    func reportNewColliderPosition(position: CGRect)
    {
        for enemy in gameManager.enemies
        {
            enemy.updatePlayerCollisionLoc(position)
        }
    }
    
    // MARK: MazeManagerDelegate functions
    func redrawMaze()
    {
        mazeView.setNeedsDisplay()
    }
}
