//
//  GameManager.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation

enum DifficultyMode {
    case Easy
    case Hard
}

class GameManager {
    
    var mode: DifficultyMode = DifficultyMode.Easy
    var playerName: String = ""
    var score: Int = 0
    let maze: Maze = Maze()
//    let player: Player?
    var enemies: [EnemyView]?
//    var coins: [Coin]
//    let timer: NSTimer // ? maybe something else, I did no research
    
    
}