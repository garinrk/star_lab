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
    var timestamp: NSDate
    
    func toDict() -> [String:AnyObject]
    {
        return ["Name":name, "Score": score, "Difficulty": difficulty.rawValue, "Time": timestamp]
    }
    
    init(name: String, score: Int, difficulty: DifficultyMode, timestamp: NSDate)
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
        let _timestamp: NSDate? = dict["Time"] as? NSDate
        
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
            difficulty = DifficultyMode.Easy
            timestamp = NSDate()
        }
    }
    
}

class ScoreManager {
    
    private var _effectsSoundLevel : Float?
    private var _musicSoundLevel : Float?
    private var _gameDifficulty : DifficultyMode = .Easy
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
    
    
    func addScore(newScore: ScoreInfo)
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
        
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingString("/LabScores.plist")
        
        var tmpArray: [[String:AnyObject]] = []
        
        for score in scores {
            tmpArray.append(score.toDict())
        }
        
        let array: NSArray = tmpArray
        
        if filePath != nil {
            array.writeToFile(filePath!, atomically: true)
        }
    
    }
    
    func loadScores() -> NSMutableArray? {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingString("/LabScores")
        
        if filePath != nil {
           return NSMutableArray(contentsOfFile: filePath!)
        }
        else {
            return nil
        }
    }
    

    
}