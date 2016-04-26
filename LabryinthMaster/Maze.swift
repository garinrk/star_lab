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
    var goal: Bool = false
    
    init(x: Int, y: Int)
    {
        self.x = x
        self.y = y
    }
}

class Maze {
    
    let dimension: Int = 30
    var cells: [MazeCell] = []
    private var visited: [Bool]?
    
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
        
        carvePassagesFromX(0, Y: 0)
    }
    
    func clearRandomWalls(amt: Int)
    {
        for _ in 0 ..< amt {
            
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
                        clearWallInCell(cell, InDir: 0)
                    }
                    break
                case 1:
                    if cell.east && cell.x != (dimension - 1)
                    {
                        keepGoing = false
                        clearWallInCell(cell, InDir: 1)
                    }
                    break
                case 2:
                    if cell.south && cell.y != (dimension - 1)
                    {
                        keepGoing = false
                        clearWallInCell(cell, InDir: 2)
                    }
                    break
                case 3:
                    if cell.west && cell.x != 0
                    {
                        keepGoing = false
                        clearWallInCell(cell, InDir: 3)
                    }
                    break
                default:
                    break
                }
            }
        }
    }
    
    
    
    private func carvePassagesFromX(x:Int, Y y:Int)
    {
        markVisitedX(x, Y: y)
        
        let cell: MazeCell = cellAtX(x, Y: y)!
        
        let directions: [Int] = randomDirections()
        
        for direction in directions
        {
            let neighbor: MazeCell? = neighborCell(cell, InDir: direction)
            if neighbor != nil && !getVisitedX(neighbor!.x, Y: neighbor!.y)
            {
                clearWallInCell(cell, InDir: direction)
                carvePassagesFromX(neighbor!.x, Y: neighbor!.y)
            }            
        }
    }
    

    private func cellAtX(x: Int, Y y: Int) -> MazeCell?
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
    private func neighborCell(cell: MazeCell, InDir dir: Int) -> MazeCell?
    {
        switch dir {
        case 0:
            return cellAtX(cell.x, Y: cell.y-1)
        case 1:
            return cellAtX(cell.x+1, Y: cell.y)
        case 2:
            return cellAtX(cell.x, Y: cell.y+1)
        case 3:
            return cellAtX(cell.x-1, Y: cell.y)
        default:
            return nil
        }
    }
    
    
    private func randomDirections() -> [Int]
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

    private func clearWallInCell(cell: MazeCell, InDir dir: Int)
    {        
        let neighbor: MazeCell? = neighborCell(cell, InDir: dir)
        
        switch dir {
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
    
    private func getVisitedX(x: Int, Y y: Int) -> Bool
    {
        if visited == nil{
            print ("Something extraordinarily bad happened")
        }
        
        return visited![x*dimension + y]
        
        
    }
    
    private func markVisitedX(x: Int, Y y: Int)
    {
        if visited == nil{
            return
        }
        visited![x*dimension + y] = true
    }
    
}