//
//  GameManager.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

enum DifficultyMode: Int {
    case easy
    case hard
}

protocol GameManagerDelegate: class {
    func GameOverCall(score: Int)
    func WinGameCall(score: Int)
}

class GameManager: GameLoopDelegate {
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    fileprivate let enemyAmt: Int = 4
    fileprivate let maxEnemyAmt: Int = 10
    let coinAmt: Int = 30
    fileprivate let coinScoreAmt: Int = 1
    fileprivate let wallsToClear: Int = 350
    fileprivate let levelProgressionAmt: Int = 50
    fileprivate let gameTimeAmt: Int = 90
    fileprivate let timeProgressionAmt: Int = 5
    fileprivate let minGameTime: Int = 45
    
    ////////////////////////////////////////
    
    weak var delegate: GameManagerDelegate? = nil
    
    let screenRect = UIScreen.main.bounds
    
    var mode: DifficultyMode = DifficultyMode.easy
    var playerName: String = ""
    var lifetimeScore: Int = 0
    var currentScore: Int = 0
    var timeLeft: Int = 0
    var currentLevel: Int = 1

    var maze: Maze!
    var player: PlayerView!
    var enemies: [EnemyView] = []
    var timer: GameTimer!
    
    var currentGyroMagX: CGFloat = 0
    var currentGyroMagY: CGFloat = 0
    
    let gameLoop: GameLoop = GameLoop()
    
    fileprivate var dead: Bool = false
    fileprivate var isPaused : Bool = false
    
    fileprivate var gameOverController : GameOverViewController?
    
    var _scoreManager : ScoreManager = ScoreManager.sharedInstance
    
    class var sharedInstance : GameManager{
        
        struct Static{
            static var instance : GameManager?
        }
        
        if(Static.instance == nil)
        {
            Static.instance = GameManager()
        }
        
        return Static.instance!
    }
    
    init()
    {
        gameLoop.delegate = self
    }
    
    func makeNewLevel()
    {
        maze = Maze()
        
        // set up variables based on level progression
        
        var actualWallsToClear: Int = wallsToClear - (levelProgressionAmt * (currentLevel-1))
        if actualWallsToClear < 0 {
            actualWallsToClear = 0
        }
        
        var enemiesToMake: Int = enemyAmt + currentLevel
        if enemiesToMake > maxEnemyAmt {
            enemiesToMake = maxEnemyAmt
        }
        
        var gameTime: Int = gameTimeAmt - (timeProgressionAmt * (currentLevel-1))
        if gameTime < minGameTime {
            gameTime = minGameTime
        }
        
        maze.clearRandomWalls(amount: actualWallsToClear)
        
        // initialize player and enemies, etc.
        
        player = PlayerView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
        
        enemies = []
        for _ in 0 ..< enemiesToMake {
            let newEnemy: EnemyView = EnemyView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
            
            if mode == .easy {
                newEnemy.AIMode = 1
            }
            else {
                newEnemy.AIMode = 2
            }
            enemies.append(newEnemy)
        }
        
        timer = GameTimer(timeLimit: gameTime)
    }

    func startGame()
    {
        dead = false
        
        gameLoop.start()
        
        for enemy in enemies {
            enemy.start()
        }
        
        player.start()
        
        timer.StartTimer()
    }
    
    func coinCollected()
    {
        currentScore += coinScoreAmt
        lifetimeScore += coinScoreAmt
    }
    
    func pause()
    {
        isPaused = true
        gameLoop.stop()
        timer.PauseTimer()
    }
    
    func unpause()
    {
        isPaused = false
        gameLoop.start()
        timer.UnpauseTimer()
    }
    
    func win()
    {
        timer.StopTimer()
        currentLevel += 1
        currentScore = 0
        gameLoop.stop()
        delegate?.WinGameCall(score: lifetimeScore)
    }
    
    func kill()
    {
        dead = true
        
        timer.StopTimer()
        currentScore = 0
        currentLevel = 1
        gameLoop.stop()
        
        // update scoremanager with lifetime score
        _scoreManager.addScore(ScoreInfo(name: playerName, score: lifetimeScore, difficulty: mode, timestamp: Date()))
        
        delegate?.GameOverCall(score: lifetimeScore)
        lifetimeScore = 0
    }
    
    func quit()
    {
        dead = true
        
        isPaused = false
        timer.StopTimer()
        gameLoop.stop()
        currentScore = 0
        currentLevel = 1
        _scoreManager.addScore(ScoreInfo(name: playerName, score: lifetimeScore, difficulty: mode, timestamp: Date()))
        lifetimeScore = 0
    }
    
    // MARK: GameLoopDelegate functions
    
    func update() {
        if dead || isPaused{
            return
        }
        
        player.move(xMagnitude: currentGyroMagX, yMagnitude: currentGyroMagY)
        player.update()
        
        for enemy in enemies {
            enemy.update()
        }
    }
}
