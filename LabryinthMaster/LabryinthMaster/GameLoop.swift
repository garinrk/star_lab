//
//  GameLoop.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/13/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol GameLoopDelegate: class {
    func update()
}

class GameLoop: NSObject {
    
    var displayLink: CADisplayLink!
    let frameRate = 60
    
    weak var delegate: GameLoopDelegate? = nil
    
    @objc func callUpdate() {
        delegate?.update()
//        print ("frameInterval: \(frameInterval)")
    }
    
    func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(GameLoop.callUpdate))
        displayLink.preferredFramesPerSecond = frameRate
        displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    func stop() {
        if displayLink != nil {
            displayLink.remove(from: RunLoop.main, forMode: RunLoop.Mode.common)
        }
        displayLink = nil
//        print("stopped")
    }
}
