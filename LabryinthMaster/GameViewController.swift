//
//  GameViewController.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController : UIViewController, GyroDelegate, EnemyViewDelegate, PlayerDelegate, GameManagerDelegate, GameTimerDelegate {
    let screenRect = UIScreen.mainScreen().bounds
    var gyroManager : Gyro?
    
    var scoreLabel: UILabel!
    var timerLabel: UILabel!
    var levelLabel: UILabel!
    var pauseButton = UIButton(type: UIButtonType.Custom)
    
    var mazeView: MazeView!
    var gameManager: GameManager!
    var audioManager: AudioManager!
    
    var gameOverController : GameOverViewController?
    var levelCompleteController : LevelCompleteViewController?
    var pauseController : PauseViewController?
    
    override func loadView() {
        super.loadView()
        
        //hide back button and top bar
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.hidden = true
        
        //MANAGERS
        audioManager = AudioManager()
        gameManager = GameManager()
        gameManager.delegate = self
        
        makeNewLevel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize and start gyro control
        
        gyroManager = Gyro()
        gyroManager?.delegate = self
        gyroManager?.Start()
    }
    
    func makeNewLevel()
    {
        // get rid of old views
        for sview in view.subviews {
            sview.removeFromSuperview()
        }
        
        gameManager.makeNewLevel()
        
        // initialize maze view
        
        mazeView = MazeView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
        for cell in gameManager.maze.cells {
            mazeView.addCellNorth(cell.north, East: cell.east, South: cell.south, West: cell.west, AtX: cell.x, Y: cell.y)
        }
        for _ in 0 ..< gameManager.coinAmt {
            mazeView.placeRandomCoin()
        }
        
        mazeView.placeGoalX(29, Y: 29)
        
        // add subviews and assign delegates
        view.addSubview(mazeView)
        
        for enemy in gameManager.enemies {
            view.addSubview(enemy)
            enemy.delegate = self
        }
        view.addSubview(gameManager.player)
        gameManager.player.delegate = self
        
        gameManager.timer.delegate = self
        
        scoreLabel = UILabel(frame: CGRect(x: 50.0, y: screenRect.width + 75.0, width: screenRect.width, height: 80.0))
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.text = "SCORE: \(gameManager.currentScore)"
        view.addSubview(scoreLabel)
        
        timerLabel = UILabel(frame: CGRect(x: 50.0, y: screenRect.width + 115.0, width: screenRect.width, height: 80.0))
        timerLabel.textColor = UIColor.whiteColor()
        timerLabel.text = "TIME LEFT: \(gameManager.timeLeft)"
        view.addSubview(timerLabel)
        
        levelLabel = UILabel(frame: CGRect(x: 50.0, y: screenRect.width + 155.0, width: screenRect.width, height: 80.0))
        levelLabel.textColor = UIColor.whiteColor()
        levelLabel.text = "LEVEL: \(gameManager.currentLevel)"
        view.addSubview(levelLabel)
        
        pauseButton.frame = CGRectMake(screenRect.width * 0.9, screenRect.width + 205.0, 75, 40.0)
        pauseButton.setTitle("PAUSE", forState: UIControlState.Normal)
        pauseButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        pauseButton.backgroundColor = UIColor.darkGrayColor()
        pauseButton.addTarget(self, action: #selector(GameViewController.PauseGame), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(pauseButton)
        // start the game
        
        gameManager.startGame()
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
        audioManager.PlayAudio(SoundType.EnemyKill)
        gameManager.kill()
        makeNewLevel()
    }

    
    // MARK: PlayerDelegate functions
    func detectCollisionFromPlayer(square: CGRect) -> Collision
    {
        return mazeView.detectCollisionWithRect(square)
    }
    func coinCollected(coll: Collision)
    {
        for coinView in mazeView.subviews{
            if coinView.tag == coll.collisionTag
            {
                coinView.setNeedsDisplay()
            }
        }
        mazeView.cells["\(coll.cellX),\(coll.cellY)"]?.hasCoin = false        
        gameManager.coinCollected()
        audioManager.PlayAudio(SoundType.Coin)
        scoreLabel.text = "SCORE: \(gameManager.currentScore)"
    }
    func reportNewColliderPosition(position: CGRect)
    {
        for enemy in gameManager.enemies
        {
            enemy.updatePlayerCollisionLoc(position)
        }
    }
    func goalReached()
    {
        audioManager.PlayAudio(SoundType.Win)
        gameManager.win()
        makeNewLevel()
        levelLabel.text = "LEVEL: \(gameManager.currentLevel)"
    }
    
    // MARK: GameManagerDelegate functions
//    func redrawMaze()
//    {
//        mazeView.setNeedsDisplay()
//    }
    
    
    func GameOverCall(){
    
        gameOverController = GameOverViewController()
        audioManager.StopAllAudio()
        self.navigationController?.pushViewController(gameOverController!, animated: true)
        
    }
    
    func WinGameCall(){
        levelCompleteController = LevelCompleteViewController()
        audioManager.StopAllAudio()
        self.navigationController?.pushViewController(levelCompleteController!, animated: true)
    }
    
    // MARK: GameTimerDelegate functions
    func updateTime(time: Int)
    {
        gameManager.timeLeft = time
        timerLabel.text = "TIME LEFT: \(gameManager.timeLeft)"
        if time <= 0
        {
            audioManager.PlayAudio(SoundType.OutOfTime)
            gameManager.kill()
            makeNewLevel()
        }
    }
    
    func PauseGame(){
        
        print("PAUSE")
        pauseController = PauseViewController()
        self.navigationController?.pushViewController(pauseController!, animated: false)
        
    }
    
    

}
