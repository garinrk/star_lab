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
    var frameInterval: Int = 1
    // 1 is equal to refresh rate of display
    // see https://developer.apple.com/library/ios/documentation/QuartzCore/Reference/CADisplayLink_ClassRef/#//apple_ref/occ/instp/CADisplayLink/frameInterval
    
    weak var delegate: GameLoopDelegate? = nil
    
    func callUpdate() {
        delegate?.update()
//        print ("frameInterval: \(frameInterval)")
    }
    
    func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(GameLoop.callUpdate))
        displayLink.frameInterval = frameInterval
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    func stop() {
        if displayLink != nil {
            displayLink.remove(from: RunLoop.main, forMode: RunLoopMode.commonModes)
        }
        displayLink = nil
//        print("stopped")
    }
}
