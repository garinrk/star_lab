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

class GameManager: GameLoopDelegate {
    
    //// GAMEPLAY ADJUSTMENT VARIABLES /////
    
    private let enemyAmt: Int = 4
    
    ////////////////////////////////////////
    
    
    let screenRect = UIScreen.mainScreen().bounds
    
    var mode: DifficultyMode = DifficultyMode.Easy
    var playerName: String = ""
    var score: Int = 0
    let maze: Maze = Maze()
    let player: PlayerView!
    var enemies: [EnemyView] = []
//    var coins: [Coin]
//    let timer: NSTimer // ? maybe something else, I did no research
    
    
    let gameLoop: GameLoop = GameLoop()

    init()
    {
        player = PlayerView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
        
        for _ in 0 ..< enemyAmt {
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

    }
    
    
    // MARK: GameLoopDelegate functions
    
    func update() {
        
        player.update()
        
        for enemy in enemies {
            enemy.update()
        }
        
        
    }
}