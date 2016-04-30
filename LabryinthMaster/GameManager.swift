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
    
    ////////////////////////////////////////
    
    weak var delegate: GameManagerDelegate? = nil
    
    let screenRect = UIScreen.mainScreen().bounds
    
    var mode: DifficultyMode = DifficultyMode.Easy
    var playerName: String = ""
    var score: Int = 0
    var maze: Maze!
    var player: PlayerView!
    var enemies: [EnemyView] = []
//    let timer: NSTimer // ? maybe something else, I did no research
    
    
    var currentGyroMagX: CGFloat = 0
    var currentGyroMagY: CGFloat = 0
    
    private var currentLevel: Int = 1
//    private var mazeNeedsRedraw: Bool = false
    
    let gameLoop: GameLoop = GameLoop()

//    init()
//    {
//
//    }
    
    func makeNewLevel()
    {
        maze = Maze()
        
        let actualWallsToClear: Int = wallsToClear - (levelProgressionAmt * (currentLevel-1))
        var enemiesToMake: Int = enemyAmt + currentLevel
        if enemiesToMake > maxEnemyAmt {
            enemiesToMake = maxEnemyAmt
        }
        
        maze.clearRandomWalls(actualWallsToClear)
        
        player = PlayerView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
        
        enemies = []
        for _ in 0 ..< enemiesToMake {
            enemies.append(EnemyView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width)))
        }
        
        gameLoop.delegate = self
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
//        mazeNeedsRedraw = true
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
//        if mazeNeedsRedraw {
//            delegate?.redrawMaze()
//            mazeNeedsRedraw = false
//        }
//        delegate?.redrawMaze()

        
        player.moveX(currentGyroMagX, Y: currentGyroMagY)
        player.update()
        
        for enemy in enemies {
            enemy.update()
        }
    }
}