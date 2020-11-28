//
//  MusicPlayer.swift
//  Ahorcado
//
//  Created by Alejandro D on 28/11/20.
//

import Foundation
import AVKit

struct GameMusicPlayer {
    public static var isSoundEnabled : Bool = true
    public static var sound : NSSound = NSSound(contentsOfFile: "/Users/alejandro/Downloads/[FREE] $uicideboy$ Type Beat Chimera (Prod. NetuH)  Dark Trap Beat.m4a", byReference: true)!
    
    public static func playSound() {
        guard isSoundEnabled == true else { return }
        GameMusicPlayer.sound.play()
    }
}
