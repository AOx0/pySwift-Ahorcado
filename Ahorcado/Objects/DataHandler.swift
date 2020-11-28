//
//  DataHandler.swift
//  Ahorcado
//
//  Created by Alejandro D on 27/11/20.
//

import Foundation

class DataHandler : ObservableObject {
    let debugger : DebuggerObj = DebuggerObj()
    
    static public func getMaxScore() -> MaxScore {
        let maxScoreString : String = CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath)/Contents/Resources/getMaxScore.py '\(NSHomeDirectory())'`")
        var tempValue : String = ""
        var tempStage : Int = 1
        
        var inEasy = 0, inDefault = 0, inHard = 0
        for char in maxScoreString {
            if char != ":" {
                tempValue += String(char)
            } else {
                switch tempStage {
                case 1:
                    inEasy = Int(tempValue)!
                    tempStage += 1
                case 2:
                    inDefault = Int(tempValue)!
                    tempStage += 1
                case 3:
                    inHard = Int(tempValue)!
                    tempStage = 1
                default: break;
                }
                tempValue = ""
            }
        }
        return MaxScore(inEasy: inEasy, inDefault: inDefault, inHard: inHard)
    }
    
    static public func getDifficulty() -> GameDifficulty {
        let dificulty : String = CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) '\(Bundle.main.bundlePath)/Contents/Resources/getDifficulty.py' '\(NSHomeDirectory())'`")
            
        switch dificulty {
            case "default": return GameDifficulty.inDefault
            case "easy": return GameDifficulty.inEasy
            default: return GameDifficulty.inHard
        }
    }
    
    static func makeDefaultData() {
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/; mkdir AOX0")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/AOX0; touch save.json")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/AOX0; less \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/File.txt > save.json")
    }
    
    static func saveDoesNotExists() -> Bool {
        if CommandRunner.execResult("cd \(NSHomeDirectory())/Library/Application\\ Support/; [ -d 'AOX0' ] && echo 'Exists.' || echo 'Error'").contains("Error") {
            return true
        } else {
            return false
        }
    }
    
    static func setDificulty(difficulty: String) {
        CommandRunner.voidExec("cd \(NSHomeDirectory()); echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/setDifficulty.py '\(NSHomeDirectory())' '\(difficulty)'`")
    }
    
    static func setMaxScore(difficulty : GameDifficulty, maxScore: MaxScore) {
        switch difficulty {
            case .inEasy:
                CommandRunner.voidExec("\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/setMaxScore.py '\(NSHomeDirectory())' '\(maxScore.inEasy)' '\(difficulty.passDifficulty())'")
            case .inDefault:
                CommandRunner.voidExec("\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/setMaxScore.py '\(NSHomeDirectory())' '\(maxScore.inDefault)' '\(difficulty.passDifficulty())'")
            default:
                CommandRunner.voidExec("\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/setMaxScore.py '\(NSHomeDirectory())' '\(maxScore.inHard)' '\(difficulty.passDifficulty())'")
        }
    }
}
