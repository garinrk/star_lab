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
    var difficulty: DifficultyMode
    var timestamp: Date
    
    func toDict() -> [String:AnyObject]
    {
        return ["Name":name as AnyObject, "Score": score as AnyObject, "Difficulty": difficulty.rawValue as AnyObject, "Time": timestamp as AnyObject]
    }
    
    init(name: String, score: Int, difficulty: DifficultyMode, timestamp: Date)
    {
        self.name = name
        self.score = score
        self.difficulty = difficulty
        self.timestamp = timestamp
    }
    
    init(FromDict dict: [String:AnyObject])
    {
        let _name: String? = dict["Name"] as? String
        let _score: Int? = dict["Score"] as? Int
        let _difficulty: Int? = dict["Difficulty"] as? Int
        let _timestamp: Date? = dict["Time"] as? Date
        
        if _name != nil && _score != nil && _difficulty != nil && _timestamp != nil{
            name = _name!
            score = _score!
            difficulty = DifficultyMode(rawValue: _difficulty!)!
            timestamp = _timestamp!
        }
        else {
            print("FAILED TO INITIALIZE FROM SAVED FILE")
            name = ""
            score = 0
            difficulty = DifficultyMode.easy
            timestamp = Date()
        }
    }
    
}

class ScoreManager {
    
    fileprivate var _effectsSoundLevel : Float?
    fileprivate var _musicSoundLevel : Float?
    fileprivate var _gameDifficulty : DifficultyMode = .easy
    fileprivate var _lifetimeScore : Int?
    fileprivate var _levelsComplete : Int?
    fileprivate var _playerName : String?
    
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
    
    var scores: [ScoreInfo] = [] // sorted based on score
    
    init(){
        
        let savedScores: NSMutableArray? = loadScores()
        if savedScores != nil {
            for score in savedScores!
            {
                let scoreInfo: ScoreInfo = ScoreInfo(FromDict: score as! [String : AnyObject])
                scores.append(scoreInfo)
            }
        }
        
    }
    
    
    func addScore(_ newScore: ScoreInfo)
    {
        scores.append(newScore)
        
        // bubble new item up by score
        var keepGoing: Bool = true
        var i: Int = scores.count - 1
        while keepGoing && i > 0{
            if scores[i].score > scores[i-1].score
            {
                let tmp: ScoreInfo = scores[i-1]
                scores[i-1] = scores[i]
                scores[i] = tmp
                i-=1
            }
            else
            {
                keepGoing = false
            }
        }
        
        saveScores()
    }
    
    
    /**
     Saves scoreinfos to the plist
     */
    func saveScores(){
        
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String?
        let filePath: String? = (documentsDirectory)! + "/LabScores.plist"
        
        var tmpArray: [[String:AnyObject]] = []
        
        for score in scores {
            tmpArray.append(score.toDict())
        }
        
        let array: NSArray = tmpArray as NSArray
        
        if filePath != nil {
            array.write(toFile: filePath!, atomically: true)
        }
    
    }
    
    func loadScores() -> NSMutableArray? {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String?
        let filePath: String? = (documentsDirectory)! + "/LabScores.plist"
        
        if filePath != nil {
           return NSMutableArray(contentsOfFile: filePath!)
        }
        else {
            return nil
        }
    }
    

    
}
