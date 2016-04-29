//
//  AudioManager.swift
//  Movement_Test
//
//  Created by Garin Richards on 4/29/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager : NSObject{
    
    var mainMusicPlayer : AVAudioPlayer!
    var confirmPlayer : AVAudioPlayer!
    var rejectPlayer : AVAudioPlayer!
    
    var fx1Player : AVAudioPlayer!
    var fx2Player : AVAudioPlayer!
    var fx3Player : AVAudioPlayer!
    var fx4Player : AVAudioPlayer!
    var fx5Player : AVAudioPlayer!
    
    var mainMusicVolume : Float = 1.0
    var fx1Volume : Float = .5
    var fx2Volume : Float = .5
    var fx3Volume : Float = .5
    var fx4Volume : Float = .5
    var fx5Volume : Float = .5
    
    
    override init(){
        super.init()
        LoadFilesIntoPlayers()
    }
    
    /**
     Loads the appropriate files into their respective players, a setup
     */
    func LoadFilesIntoPlayers(){
     
        //Step 1: Get files
        guard let mainMusicURL = NSBundle.mainBundle().URLForResource("Audio/mainMusic", withExtension: "mp3") else {
            print("could not read main Music file")
            return
        }
        
        guard let fx1URL = NSBundle.mainBundle().URLForResource("Audio/fx1", withExtension: "mp3") else {
            print("could not read fx1 file")
            return
        }
        
        guard let fx2URL = NSBundle.mainBundle().URLForResource("Audio/fx2", withExtension: "mp3") else {
            print("could not read fx2 file")
            return
        }
        guard let fx3URL = NSBundle.mainBundle().URLForResource("Audio/fx3", withExtension: "mp3") else {
            print("could not read fx3 file")
            return
        }
        guard let fx4URL = NSBundle.mainBundle().URLForResource("Audio/fx4", withExtension: "mp3") else {
            print("could not read fx4 file")
            return
        }
        
        guard let fx5URL = NSBundle.mainBundle().URLForResource("Audio/fx5", withExtension: "mp3") else {
            print("could not read fx5 file")
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
            try self.fx1Player = AVAudioPlayer(contentsOfURL: fx1URL)
        } catch {
            print("could not create fx1Player \(error)")
            return
        }
       
        do {
            try self.fx2Player = AVAudioPlayer(contentsOfURL: fx2URL)
        } catch {
            print("could not create fx2Player \(error)")
            return
        }
        do {
            try self.fx3Player = AVAudioPlayer(contentsOfURL: fx3URL)
        } catch {
            print("could not create fx3Player \(error)")
            return
        }
        do {
            try self.fx4Player = AVAudioPlayer(contentsOfURL: fx4URL)
        } catch {
            print("could not create fx4Player \(error)")
            return
        }
        do {
            try self.fx5Player = AVAudioPlayer(contentsOfURL: fx5URL)
        } catch {
            print("could not create fx5Player \(error)")
            return
        }
        
        //Step 3: Set delegates, volumes, prepare to play, and callback method
        
        mainMusicPlayer.delegate = self
        fx1Player.delegate = self
        fx2Player.delegate = self
        fx3Player.delegate = self
        fx4Player.delegate = self
        fx5Player.delegate = self
        
        mainMusicPlayer.prepareToPlay()
        fx1Player.prepareToPlay()
        fx2Player.prepareToPlay()
        fx3Player.prepareToPlay()
        fx4Player.prepareToPlay()
        fx5Player.prepareToPlay()
        
        mainMusicPlayer.volume = mainMusicVolume
        fx1Player.volume = fx1Volume
        fx2Player.volume = fx2Volume
        fx3Player.volume = fx3Volume
        fx4Player.volume = fx4Volume
        fx5Player.volume = fx5Volume
        
//        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:Selector("sessionInterrupted:"),
                                                         name:AVAudioSessionInterruptionNotification,
                                                         object:mainMusicPlayer)
    }
    
//    func AudioInterrupted(){
//        
//    }
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
