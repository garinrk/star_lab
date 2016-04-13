//
//  Maze.swift
//  LabryinthMaster
//
//  Created by M on 4/9/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation

struct MazeCell {
    var x: Int
    var y: Int
    var north: Bool
    var east: Bool
    var south: Bool
    var west: Bool
}

class Maze {
    
    var cells: [MazeCell] = []
    let dimension: Int = 30
    
    init ()
    {
        for var i = 0; i < dimension; i++ {
            for var j = 0; j < dimension; j++ {
                
                let diceRoll: Bool = Bool(Int(arc4random_uniform(2)))
                let diceRoll2: Bool = Bool(Int(arc4random_uniform(2)))
                
                cells.append(MazeCell(x: i, y: j, north: diceRoll, east: false, south: false, west: diceRoll2))
            }
        }
        
    }
    
    func generateMaze()
    {
        
        
//        Recursive division: This algorithm is somewhat similar to recursive backtracking, since they're both stack based, except this focuses on walls instead of passages. 
        
        //Start by making a random horizontal or vertical wall crossing the available area in a random row or column, with an opening randomly placed along it. 
        
        
        
        
        //Then recursively repeat the process on the two subareas generated by the dividing wall. 
        
        //For best results, give bias to choosing horizontal or vertical based on the proportions of the area, e.g. an area twice as wide as it is high should be divided by a vertical wall more often. This is the fastest algorithm without directional biases, and can even rival binary tree mazes because it can finish multiple cells at once, although it has the obvious blemish of long walls crossing the interior. This algorithm is a form of nested fractal Mazes, except instead of always making fixed cell size Mazes with Mazes of the same size within each cell, it divides the given area randomly into a random sized 1x2 or 2x1 Maze. Recursive division doesn't work as a passage carver, because doing so results in an obvious solution path that either follows the outside edge or else directly crosses the interior.

        
    }
    
    
}