//
//  MusicPlayer.swift
//  Ahorcado
//
//  Created by Alejandro D on 28/11/20.
//

import Foundation
import AVKit

enum MusicState {
    case paused
    case playing
    case stopped
}

struct GameMusicPlayer {
    
    public static var isSoundEnabled : Bool = true
    public static var sound : NSSound = NSSound(contentsOfFile: "\(Bundle.main.bundlePath)/Contents/Resources/Music.m4a", byReference: true)!
    
    public static func playSound() {
        GameMusicPlayer.sound.play()
    }
    
    public static func stopSound() {
        GameMusicPlayer.sound.stop()
    }
    
    public static func pauseSound() {
        GameMusicPlayer.sound.pause()
    }
    
    public static func resumeSound() {
        GameMusicPlayer.sound.resume()
    }
    
}
