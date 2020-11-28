//
//  EnvObjectImp.swift
//  Ahorcado
//
//  Created by Alejandro D on 27/11/20.
//

import Foundation

extension EnvObject {
    
    func swiftGenDisplayWord() -> String {
        return ""
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
