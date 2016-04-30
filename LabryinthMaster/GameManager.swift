//
//  GameManager.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

enum DifficultyMode {
    case Easy
    case Hard
}

protocol GameManagerDelegate: class {
    func redrawMaze()
}

class GameManager: GameLoopDelegate {
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    private let enemyAmt: Int = 4
    private let maxEnemyAmt: Int = 10
    let coinAmt: Int = 30
    private let coinScoreAmt: Int = 1
    private let wallsToClear: Int = 350
    private let levelProgressionAmt: Int = 50
    private let gameTimeAmt: Int = 90
    private let timeProgressionAmt: Int = 5
    private let minGameTime: Int = 45
    
    ////////////////////////////////////////
    
    weak var delegate: GameManagerDelegate? = nil
    
    let screenRect = UIScreen.mainScreen().bounds
    
    var mode: DifficultyMode = DifficultyMode.Easy
    var playerName: String = ""
    var score: Int = 0
    var timeLeft: Int = 0
    var maze: Maze!
    var player: PlayerView!
    var enemies: [EnemyView] = []
    var timer: GameTimer!
    
    var currentGyroMagX: CGFloat = 0
    var currentGyroMagY: CGFloat = 0
    
    private var currentLevel: Int = 1
    
    let gameLoop: GameLoop = GameLoop()
    
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
        
        maze.clearRandomWalls(actualWallsToClear)
        
        // initialize player and enemies, etc.
        
        player = PlayerView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
        
        enemies = []
        for _ in 0 ..< enemiesToMake {
            enemies.append(EnemyView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width)))
        }
        
        gameLoop.delegate = self
        
        timer = GameTimer(timeLimit: gameTime)
    }

    func startGame()
    {
        gameLoop.start()
        
        for enemy in enemies {
            enemy.start()
        }
        
        player.start()
    }
    
    func coinCollected()
    {
        score += coinScoreAmt
    }
    
    func win()
    {
        currentLevel += 1
    }
    
    func kill()
    {
        score = 0
    }
    
    // MARK: GameLoopDelegate functions
    
    func update() {
        
        player.moveX(currentGyroMagX, Y: currentGyroMagY)
        player.update()
        
        for enemy in enemies {
            enemy.update()
        }
    }
}