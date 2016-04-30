//
//  AudioManager.swift
//  Movement_Test
//
//  Created by Garin Richards on 4/29/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation
import AVFoundation

enum SoundType{
    case MainMusic
    case Confirm
    case EnemyKill
    case Coin
    case Win
    case OutOfTime
    case StartLevel
}

class AudioManager : NSObject{
    
    var mainMusicPlayer : AVAudioPlayer!
    var confirmPlayer : AVAudioPlayer!
    var enemyKillPlayer : AVAudioPlayer!
    var coinPlayer : AVAudioPlayer!
    var winPlayer : AVAudioPlayer!
    var outOfTimePlayer : AVAudioPlayer!
    var startLevelPlayer : AVAudioPlayer!
    
    var mainMusicVolume : Float = 1.0
    var confirmVolume : Float = 0.75
    var enemyKillVolume : Float = 0.75
    var coinVolume : Float = 0.5
    var winVolume : Float = 0.5
    var outOfTimeVolume : Float = 0.5
    var startLevelVolume : Float = 0.5
    
    
    override init(){
        super.init()
        LoadFilesIntoPlayers()
        SetupAudioSession()
    }
    
    /**
     Loads the appropriate files into their respective players, a setup
     */
    func LoadFilesIntoPlayers(){
        
        //Step 1: Get files
        guard let mainMusicURL = NSBundle.mainBundle().URLForResource("mainMusic", withExtension: "mp3") else {
            print("could not read main Music file")
            return
        }
        guard let confirmURL = NSBundle.mainBundle().URLForResource("menu", withExtension: "wav") else {
            print("could not read confirm file")
            return
        }
        
        guard let enemyKillURL = NSBundle.mainBundle().URLForResource("enemy", withExtension: "wav") else {
            print("could not read reject file")
            return
        }
        
        guard let coinURL = NSBundle.mainBundle().URLForResource("coin", withExtension: "wav") else {
            print("could not read fx1 file")
            return
        }
        
        guard let winURL = NSBundle.mainBundle().URLForResource("win2", withExtension: "wav") else {
            print("could not read fx2 file")
            return
        }
        guard let outOfTimeURL = NSBundle.mainBundle().URLForResource("outoftime", withExtension: "wav") else {
            print("could not read fx3 file")
            return
        }
        guard let startLevelURL = NSBundle.mainBundle().URLForResource("start", withExtension: "wav") else {
            print("could not read fx4 file")
            return
        }
        
        //Step 2: Load
        
        do {
            try self.mainMusicPlayer = AVAudioPlayer(contentsOfURL: mainMusicURL)
        } catch {
            print("could not create mainMusicPlayer \(error)")
            return
        }
        
        do {
            try self.confirmPlayer = AVAudioPlayer(contentsOfURL: confirmURL)
        } catch {
            print("could not create confirmplayer \(error)")
            return
        }
        
        do {
            try self.enemyKillPlayer = AVAudioPlayer(contentsOfURL: enemyKillURL)
        } catch {
            print("could not create rejectplayer \(error)")
            return
        }
        
        do {
            try self.coinPlayer = AVAudioPlayer(contentsOfURL: coinURL)
        } catch {
            print("could not create fx1Player \(error)")
            return
        }
        
        do {
            try self.winPlayer = AVAudioPlayer(contentsOfURL: winURL)
        } catch {
            print("could not create fx2Player \(error)")
            return
        }
        do {
            try self.outOfTimePlayer = AVAudioPlayer(contentsOfURL: outOfTimeURL)
        } catch {
            print("could not create fx3Player \(error)")
            return
        }
        do {
            try self.startLevelPlayer = AVAudioPlayer(contentsOfURL: startLevelURL)
        } catch {
            print("could not create fx4Player \(error)")
            return
        }
        
        //Step 3: Set delegates, volumes, prepare to play, and callback method
        
        mainMusicPlayer.delegate = self
        confirmPlayer.delegate = self
        enemyKillPlayer.delegate = self
        coinPlayer.delegate = self
        winPlayer.delegate = self
        outOfTimePlayer.delegate = self
        startLevelPlayer.delegate = self
        
        
        mainMusicPlayer.prepareToPlay()
        confirmPlayer.prepareToPlay()
        enemyKillPlayer.prepareToPlay()
        coinPlayer.prepareToPlay()
        winPlayer.prepareToPlay()
        outOfTimePlayer.prepareToPlay()
        startLevelPlayer.prepareToPlay()
        
        mainMusicPlayer.volume = mainMusicVolume
        confirmPlayer.volume = confirmVolume
        enemyKillPlayer.volume = enemyKillVolume
        coinPlayer.volume = coinVolume
        winPlayer.volume = winVolume
        outOfTimePlayer.volume = outOfTimeVolume
        startLevelPlayer.volume = startLevelVolume
        
    }
    
    
    /**
     Pauses all audio players
     */
    func PauseAllAudio(){
        if mainMusicPlayer.playing{
            mainMusicPlayer.pause()
        }
        
        if confirmPlayer.playing{
            confirmPlayer.pause()
        }
        
        if enemyKillPlayer.playing{
            enemyKillPlayer.pause()
        }
        
        if coinPlayer.playing{
            coinPlayer.pause()
        }
        
        if winPlayer.playing{
            winPlayer.pause()
        }
        
        if outOfTimePlayer.playing{
            outOfTimePlayer.pause()
        }
        
        if startLevelPlayer.playing{
            startLevelPlayer.pause()
        }

    }
    
    func StopAllAudio(){
        if mainMusicPlayer.playing{
            mainMusicPlayer.stop()
        }
        
        if confirmPlayer.playing{
            confirmPlayer.stop()
        }
        
        if enemyKillPlayer.playing{
            enemyKillPlayer.stop()
        }
        
        if coinPlayer.playing{
            coinPlayer.stop()
        }
        
        if winPlayer.playing{
            winPlayer.stop()
        }
        
        if outOfTimePlayer.playing{
            outOfTimePlayer.stop()
        }
        
        if startLevelPlayer.playing{
            startLevelPlayer.stop()
        }
        
    }
    
    /**
     Sets up audio session for players to be able to play
     audio
     */
    func SetupAudioSession(){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.MixWithOthers)
            try audioSession.setActive(true)
        } catch {
            print("couldn't set category \(error)")
        }
    }
    
    /**
     Plays a specified audio type
     
     - parameter audioType: The type of audio to play
     */
    func PlayAudio(audioType : SoundType)
    {
        switch audioType{
            
        case .MainMusic:
            mainMusicPlayer.play()
            break
        case .Confirm:
            confirmPlayer.play()
            break
        case .EnemyKill:
            enemyKillPlayer.play()
            break
        case .Coin:
            coinPlayer.play()
            break
        case .Win:
            winPlayer.play()
            break
        case .OutOfTime:
            outOfTimePlayer.play()
            break
        case .StartLevel:
            startLevelPlayer.play()
            break

        }
    }
}


// MARK: AVAudioPlayerDelegate
extension AudioManager : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing \(flag)")
    }
    
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
    }
    
}
