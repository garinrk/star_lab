//
//  MazeViewCellPriorityQueue.swift
//  LabryinthMaster
//
//  Created by M on 4/29/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation

struct MazeViewCellPriorityQueueNode
{
    let object: MazeViewCell
    let priority: Int
}

class MazeViewCellPriorityQueue
{
    fileprivate var queue: [MazeViewCellPriorityQueueNode] = []
    var empty: Bool
    {
        return queue.isEmpty
    }
    
    func next() -> MazeViewCell?
    {
        return queue.remove(at: 0).object
    }
    
    func addCell(cell: MazeViewCell, priority: Int)
    {
        let newNode: MazeViewCellPriorityQueueNode = MazeViewCellPriorityQueueNode(object: cell, priority: priority)
        
        queue.append(newNode)
        
        // bubble new item up by priority
        var keepGoing: Bool = true
        var i: Int = queue.count - 1
        while keepGoing && i > 0{
            if queue[i].priority > queue[i-1].priority
            {
                let tmp: MazeViewCellPriorityQueueNode = queue[i-1]                
                queue[i-1] = queue[i]
                queue[i] = tmp
                i-=1
            }
            else
            {
                keepGoing = false
            }			
        }
    }
}
