//
//  ScoreManager.swift
//  LabryinthMaster
//
//  Created by u0413046 on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation

struct ScoreInfo {
    var name: String
    var score: Int
    var timestamp: NSDate
}

enum Difficulty{
    case Hard
    case Easy
}


class ScoreManager {
    
    private var _effectsSoundLevel : Float?
    private var _musicSoundLevel : Float?
    
    
    
    class var sharedInstance : ScoreManager{
        
        struct Static{
            static var instance : ScoreManager?
        }
        
        if(Static.instance == nil)
        {
            Static.instance = ScoreManager()
        }
        
        return Static.instance!
    }
    
    var scores: [ScoreInfo]?
    
    // needs a function to sort scoreinfos based on score
    
    // needs a function to save/ load scores from plist
    
    
}