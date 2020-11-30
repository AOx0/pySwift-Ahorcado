//
//  EnvObjectImp.swift
//  Ahorcado
//
//  Created by Alejandro D on 27/11/20.
//

import Foundation
import GameKit
import SwiftUI

extension EnvObject {
    
    func generateWord(isWin : Bool=false) {
        if !isWin {
            self.lives = 9
            self.score = 0
        }
        self.letter = ""
        self.word = getRandomWord()
        self.displayedWord = containsSpecialChars() ? swiftGenDisplayWord() : pythonGenDisplayWord()
        
        print(word, displayedWord)
    }
    
    func pythonCheckLetter(newChar: String) {
        self.displayedWord = CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/checkWord.py '\(self.word.lowercased())' '\(newChar.lowercased())' '\(self.displayedWord)'`")
    }
    
    func swiftCheckLetter(newChar: String) {
        var indexes : [Int] = []
        let word_array = Array(self.word)
        
        var index = 0
        for i in Array(self.word) {
            if String(i) == newChar {
                indexes.append(index)
            }
            index += 1
        }
        
        var displayed_array = Array(self.displayedWord)
        
        for index in indexes {
            displayed_array[index] = word_array[index]
        }
        
        var finaldisplayed = ""
        
        for i in displayed_array {
            finaldisplayed += String(i)
        }
        
        self.displayedWord = finaldisplayed
    }
    
    func checarLetra(newChar: String) {
        let wordBefore = self.displayedWord
        if containsSpecialChars() {
            swiftCheckLetter(newChar: newChar)
        } else {
            pythonCheckLetter(newChar: newChar)
        }
        
        if self.displayedWord == wordBefore {
            withAnimation {
                lives -= 1
            }
        }
    }
    
    func genWord(word : String) -> String {
        var generatedDisplayWord = ""
        for char in Array(word) {
            if String(char) == " " {
                generatedDisplayWord += "\u{2003}"
            } else if true {
                let possibility : [Int] = [1,1,1,1,2,2]
                let randNumber = possibility[GKRandomDistribution(lowestValue: 0, highestValue: 5).nextInt()]
                if randNumber == 2 {
                    generatedDisplayWord += String(char)
                } else {
                    generatedDisplayWord += "ˍ"
                }
            }
        }
        return generatedDisplayWord
    }
    
    func swiftGenDisplayWord() -> String {
        var generatedDisplayWord : String = ""
        switch self.difficulty {
        case .inEasy:
            while !generatedDisplayWord.contains("ˍ") {
                generatedDisplayWord = genWord(word: self.word)
            }
        case .inDefault:
            while generatedDisplayWord.countOcurrences(of: "ˍ") < Int((Float(self.word.count) * 0.7)) {
                generatedDisplayWord = genWord(word: self.word)
            }
        case .inHard:
            for char in self.word {
                if String(char) == " " { generatedDisplayWord += "\u{2003}" } else { generatedDisplayWord += "ˍ" }
            }
        }
        return generatedDisplayWord
    }
    
    func pythonGenDisplayWord() -> String {
        return CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/genDisplayedWord.py '\(self.word.lowercased())' '\(self.difficulty.passDifficulty())'`")
    }
    
    func getRandomWord() -> String {
        return CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/genWord.py '\(NSHomeDirectory())' '\(self.difficulty.passDifficulty())'`")
    }
    
    func containsSpecialChars(_ listChars : [String] = ["ñ", "á", "ó", "ú", "é", "í", "ü", "ï"]) -> Bool {
        var containsSpecialChars : Bool = false
        for char in listChars {
            if self.word.contains(char) { containsSpecialChars = true }
        }
        return containsSpecialChars
    }
    
    func showMaxScoreOf(difficulty : GameDifficulty) -> String {
        switch difficulty {
            case .inDefault:
                return String(self.maxScore.inDefault)
            case .inEasy:
                return String(self.maxScore.inEasy)
            case .inHard:
                return String(self.maxScore.inHard)
        }
    }
    
}

extension String {
    var parsedPath : String {
        return self.replacingOccurrences(of: " ", with: "\\ ")
    }
    
    func countOcurrences(of char: String) -> Int {
        var counter = 0
        for i in Array(self) {
            if i == Character(char) {
                counter += 1
            }
        }
        return counter
    }
    
    func getCharIn(index: Int) -> String {
        return String(self[String.Index(utf16Offset: index, in: self)])
    }
}

struct MaxScore {
    var inEasy: Int
    var inDefault: Int
    var inHard: Int
}

enum GameDifficulty {
    case inDefault
    case inEasy
    case inHard
    
    func passDifficulty() -> String {
        switch self{
            case .inDefault: return "default"
            case .inEasy: return "easy"
            case .inHard: return "hard"
        }
    }
}

enum GameStage {
    case inGame
    case inSettings
    case inMenu
}

