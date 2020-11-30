//
//  EnvObj_DidSet.swift
//  Ahorcado
//
//  Created by Alejandro D on 27/11/20.
//

import Foundation
import SwiftUI

extension EnvObject {
    func gameLostActions() {
        guard isLose != false else { return }
        switch difficulty {
            case .inEasy: if score > maxScore.inEasy { self.maxScore.inEasy = score }
            case .inDefault: if score > maxScore.inDefault { self.maxScore.inDefault = score }
            default: if score > maxScore.inHard { self.maxScore.inHard = score }
        }
        self.isLose = false
    }
    
    func gameWonActions() {
        if isWin == true {
            generateWord(isWin: true)
            score += 1
            isWin = false
        }
    }
    
    func analizeIfLost() {
        if self.lives == 0 {
            isLose = true
            showLoseMessage = true
        }
    }
    
    func checkWrittenLetter() {
        guard letter.count != 0 else { return }
        let newChar = String(letter[String.Index(utf16Offset: (letter.count-1), in: letter)])
        self.checarLetra(newChar: newChar)
        if CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/checkIfWin.py '\(self.displayedWord)'`") == "win" {
            isWin = true
        }
    }
    
}
