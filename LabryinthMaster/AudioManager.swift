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
    case mainMusic
    case confirm
    case enemyKill
    case coin
    case win
    case outOfTime
    case startLevel
}

class AudioManager : NSObject{
    var mainMusicPlayer : AVAudioPlayer!
    var confirmPlayer : AVAudioPlayer!
    var enemyKillPlayer : AVAudioPlayer!
    var coinPlayer : AVAudioPlayer!
    var winPlayer : AVAudioPlayer!
    var outOfTimePlayer : AVAudioPlayer!
    var startLevelPlayer : AVAudioPlayer!
    
    var mainMusicVolume : Float = 0.25
    var effectsVolume : Float = 0.5
    
    class var sharedInstance : AudioManager{
        struct Static{
            static var instance : AudioManager?
        }
        
        if(Static.instance == nil)
        {
            Static.instance = AudioManager()
        }
        
        return Static.instance!
    }
    
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
        guard let mainMusicURL = Bundle.main.url(forResource: "mainMusic", withExtension: "mp3") else {
            print("could not read main Music file")
            return
        }
        guard let confirmURL = Bundle.main.url(forResource: "menu", withExtension: "wav") else {
            print("could not read confirm file")
            return
        }
        
        guard let enemyKillURL = Bundle.main.url(forResource: "enemy", withExtension: "wav") else {
            print("could not read reject file")
            return
        }
        
        guard let coinURL = Bundle.main.url(forResource: "coin", withExtension: "wav") else {
            print("could not read fx1 file")
            return
        }
        
        guard let winURL = Bundle.main.url(forResource: "win2", withExtension: "wav") else {
            print("could not read fx2 file")
            return
        }
        guard let outOfTimeURL = Bundle.main.url(forResource: "outoftime", withExtension: "wav") else {
            print("could not read fx3 file")
            return
        }
        guard let startLevelURL = Bundle.main.url(forResource: "start", withExtension: "wav") else {
            print("could not read fx4 file")
            return
        }
        
        //Step 2: Load
        
        do {
            try self.mainMusicPlayer = AVAudioPlayer(contentsOf: mainMusicURL)
        } catch {
            print("could not create mainMusicPlayer \(error)")
            return
        }
        
        do {
            try self.confirmPlayer = AVAudioPlayer(contentsOf: confirmURL)
        } catch {
            print("could not create confirmplayer \(error)")
            return
        }
        
        do {
            try self.enemyKillPlayer = AVAudioPlayer(contentsOf: enemyKillURL)
        } catch {
            print("could not create rejectplayer \(error)")
            return
        }
        
        do {
            try self.coinPlayer = AVAudioPlayer(contentsOf: coinURL)
        } catch {
            print("could not create fx1Player \(error)")
            return
        }
        
        do {
            try self.winPlayer = AVAudioPlayer(contentsOf: winURL)
        } catch {
            print("could not create fx2Player \(error)")
            return
        }
        do {
            try self.outOfTimePlayer = AVAudioPlayer(contentsOf: outOfTimeURL)
        } catch {
            print("could not create fx3Player \(error)")
            return
        }
        do {
            try self.startLevelPlayer = AVAudioPlayer(contentsOf: startLevelURL)
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
        confirmPlayer.volume = effectsVolume
        enemyKillPlayer.volume = effectsVolume
        coinPlayer.volume = effectsVolume
        winPlayer.volume = effectsVolume
        outOfTimePlayer.volume = effectsVolume
        startLevelPlayer.volume = effectsVolume
        
        // music set to infinite loop
        mainMusicPlayer.numberOfLoops = -1
    }
    
    /**
     Pauses all audio players
     */
    func PauseAllAudio(){
        if mainMusicPlayer.isPlaying{
            mainMusicPlayer.pause()
        }
        
        if confirmPlayer.isPlaying{
            confirmPlayer.pause()
        }
        
        if enemyKillPlayer.isPlaying{
            enemyKillPlayer.pause()
        }
        
        if coinPlayer.isPlaying{
            coinPlayer.pause()
        }
        
        if winPlayer.isPlaying{
            winPlayer.pause()
        }
        
        if outOfTimePlayer.isPlaying{
            outOfTimePlayer.pause()
        }
        
        if startLevelPlayer.isPlaying{
            startLevelPlayer.pause()
        }
    }
    
    func StopAllAudio(){
        if mainMusicPlayer.isPlaying{
            mainMusicPlayer.stop()
        }
        
        if confirmPlayer.isPlaying{
            confirmPlayer.stop()
        }
        
        if enemyKillPlayer.isPlaying{
            enemyKillPlayer.stop()
        }
        
        if coinPlayer.isPlaying{
            coinPlayer.stop()
        }
        
        if winPlayer.isPlaying{
            winPlayer.stop()
        }
        
        if outOfTimePlayer.isPlaying{
            outOfTimePlayer.stop()
        }
        
        if startLevelPlayer.isPlaying{
            startLevelPlayer.stop()
        }
    }
    
    /**
     Sets the volumes of the audio players to whatever is in the current
     global properties
     */
    func SetVolumes(){
        mainMusicPlayer.volume = mainMusicVolume
        confirmPlayer.volume = effectsVolume
        enemyKillPlayer.volume = effectsVolume
        coinPlayer.volume = effectsVolume
        winPlayer.volume = effectsVolume
        outOfTimePlayer.volume = effectsVolume
        startLevelPlayer.volume = effectsVolume
    }
    
    /**
     Sets up audio session for players to be able to play
     audio
     */
    func SetupAudioSession(){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.mixWithOthers)
            try audioSession.setActive(true)
        } catch {
            print("couldn't set category \(error)")
        }
    }
    
    /**
     Plays a specified audio type
     
     - parameter audioType: The type of audio to play
     */
    func PlayAudio(type: SoundType)
    {
        switch type{
        case .mainMusic:
            mainMusicPlayer.play()
            break
        case .confirm:
            confirmPlayer.play()
            break
        case .enemyKill:
            enemyKillPlayer.play()
            break
        case .coin:
            coinPlayer.play()
            break
        case .win:
            winPlayer.play()
            break
        case .outOfTime:
            outOfTimePlayer.play()
            break
        case .startLevel:
            startLevelPlayer.play()
            break
        }
    }
}

// MARK: AVAudioPlayerDelegate
extension AudioManager : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        print("finished playing \(flag)")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let e = error {
            print("\(e.localizedDescription)")
        }
    }
}
