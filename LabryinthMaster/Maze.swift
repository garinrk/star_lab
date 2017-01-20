//
//  Maze.swift
//  LabryinthMaster
//
//  Created by M on 4/9/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation

class MazeCell {
    var x: Int
    var y: Int
    var north: Bool = true
    var east: Bool = true
    var south: Bool = true
    var west: Bool = true
    
    init(x: Int, y: Int)
    {
        self.x = x
        self.y = y
    }
}

class Maze {
    
    let dimension: Int = 30
    var cells: [MazeCell] = []
    fileprivate var visited: [Bool]?
    
    init ()
    {
        for i in 0 ..< dimension {
            for j in 0 ..< dimension {
                cells.append(MazeCell(x: i, y: j))
            }
        }
        
        generateMaze()
    }
    
    func generateMaze()
    {
        visited = []

        for _ in 0 ..< cells.count
        {
            visited!.append(false)
        }
        
        carvePassagesFrom(x: 0, y: 0)
    }
    
    func clearRandomWalls(amount: Int)
    {
        for _ in 0 ..< amount {
            
            var keepGoing = true
            
            while keepGoing { // we want to make sure we clear out all 'amt' walls
            
                let randCellIndex: Int = Int(arc4random_uniform(UInt32(cells.count)))
                let randDir: Int = Int(arc4random_uniform(4))
                
                let cell: MazeCell = cells[randCellIndex]
                
                switch randDir {
                case 0:
                    if cell.north && cell.y != 0
                    {
                        keepGoing = false
                        clearWallIn(cell: cell, direction: 0)
                    }
                    break
                case 1:
                    if cell.east && cell.x != (dimension - 1)
                    {
                        keepGoing = false
                        clearWallIn(cell: cell, direction: 1)
                    }
                    break
                case 2:
                    if cell.south && cell.y != (dimension - 1)
                    {
                        keepGoing = false
                        clearWallIn(cell: cell, direction: 2)
                    }
                    break
                case 3:
                    if cell.west && cell.x != 0
                    {
                        keepGoing = false
                        clearWallIn(cell: cell, direction: 3)
                    }
                    break
                default:
                    break
                }
            }
        }
    }
    
    fileprivate func carvePassagesFrom(x: Int, y: Int)
    {
        markVisited(x: x, y: y)
        
        let cell: MazeCell = cellAt(x: x, y: y)!
        
        let directions: [Int] = randomDirections()
        
        for direction in directions
        {
            let neighbor: MazeCell? = self.neighbor(cell: cell, direction: direction)
            if neighbor != nil && !getVisited(x: neighbor!.x, y: neighbor!.y)
            {
                clearWallIn(cell: cell, direction: direction)
                carvePassagesFrom(x: neighbor!.x, y: neighbor!.y)
            }            
        }
    }
    
    fileprivate func cellAt(x: Int, y: Int) -> MazeCell?
    {
        if x < 0 || y < 0 || x >= dimension || y >= dimension
        {
            return nil
        }
        else {
            return cells[x*dimension + y]
        }
    }
    
    /// dir: 0 = north, 1 = east, 2 = south, 3 = west
    fileprivate func neighbor(cell: MazeCell, direction: Int) -> MazeCell?
    {
        switch direction {
        case 0:
            return cellAt(x: cell.x, y: cell.y-1)
        case 1:
            return cellAt(x: cell.x+1, y: cell.y)
        case 2:
            return cellAt(x: cell.x, y: cell.y+1)
        case 3:
            return cellAt(x: cell.x-1, y: cell.y)
        default:
            return nil
        }
    }
    
    fileprivate func randomDirections() -> [Int]
    {
        let first: Int = Int(arc4random_uniform(4))
 
        var second: Int = -1
        
        repeat {
            second = Int(arc4random_uniform(4))
        } while second == first

        var third: Int = -1
        
        repeat {
            third = Int(arc4random_uniform(4))
        } while third == second || third == first
        
        let fourth: Int = 6 - (first + second + third)
        
        return [first, second, third, fourth]
    }

    fileprivate func clearWallIn(cell: MazeCell, direction: Int)
    {        
        let neighbor: MazeCell? = self.neighbor(cell: cell, direction: direction)
        
        switch direction {
        case 0:
            cell.north = false
            neighbor?.south = false
            return
        case 1:
            cell.east = false
            neighbor?.west = false
            return
        case 2:
            cell.south = false
            neighbor?.north = false
            return
        case 3:
            cell.west = false
            neighbor?.east = false
            return
        default:
            return
        }
    }
    
    fileprivate func getVisited(x: Int, y: Int) -> Bool
    {
        if visited == nil {
            print ("Something extraordinarily bad happened")
        }
        
        return visited![x*dimension + y]
    }
    
    fileprivate func markVisited(x: Int, y: Int)
    {
        if visited == nil {
            return
        }
        visited![x*dimension + y] = true
    }
}
