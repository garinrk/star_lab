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

struct SessionData{
    var ID : String
    var playerName : String
    var lifetimeScore : Int
    var levelsComplete : Int
    var difficulty : Difficulty
}

enum Difficulty{
    case Hard
    case Easy
    case Temp
}

//session id, player name, lifetime score, number oflevels
//difficulty mode

class ScoreManager {
    
    private var _effectsSoundLevel : Float?
    private var _musicSoundLevel : Float?
    private var _gameDifficulty : Difficulty = .Temp
    private var _lifetimeScore : Int?
    private var _levelsComplete : Int?
    private var _playerName : String?
    
    
    
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
    
//    override init(){
//        //get the difficulty from the plist
//    }
//    
    
    /**
     Saves a given sessionData object to the plist
     
     - parameter sessionID: <#sessionID description#>
     */
    func SaveSessionData(data : SessionData){
        
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingString("/LabData.plist")
        
        var tmpArray: [[String:AnyObject]] = []
        
        //create dictionary of session data
        
        let sessionDictionary : [String : String] = [
            "ID" : data.ID,
            "playerName" : data.playerName,
            "levelsComplete" : String(data.levelsComplete),
            "lifetimeScore" : String(data.lifetimeScore),
            "difficulty" : String(data.difficulty)
            
        ]
        tmpArray.append(sessionDictionary)
        
        let array: NSArray = tmpArray
        
        if filePath != nil {
            array.writeToFile(filePath!, atomically: true)
        }
    
    }
    
    /**
     ???????????????????
     
     - parameter sessionID: <#sessionID description#>
     
     - returns: <#return value description#>
     */
    func LoadSessionData(sessionID: String) -> SessionData{
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingString("/LabData.plist")
        
        var returnArray : NSMutableArray
        
        var loadedData : SessionData?
        
        if filePath != nil {
           returnArray = NSMutableArray(contentsOfFile: filePath!)!
        }
        
        var data = returnArray as AnyObject as! [String]
        
        
        return loadedData!
    }
    

    
}