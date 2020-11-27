//
//  DataObject.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//



import Foundation

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

class EnvObject : ObservableObject {
    @Published var debugMessage = ""
    @Published var showLoseMessage : Bool = false
    
    @Published var stage : GameStage = GameStage.inMenu
    @Published var difficulty = GameDifficulty.inDefault {
        didSet {
            self.setDificulty()
        }
    }
    
    @Published var lives : Int = 9 {
        didSet {
            if self.lives == 0 {
                isLose = true
                showLoseMessage = true
            }
        }
    }
    @Published var maxScore : MaxScore {
        didSet {
            setMaxScore()
        }
    }
    @Published var score : Int = 0
    
    @Published var isLose : Bool = false {
        didSet {
            guard isLose != false else { return }
            switch difficulty {
                case .inEasy: if score > maxScore.inEasy { self.maxScore.inEasy = score }
                case .inDefault: if score > maxScore.inDefault { self.maxScore.inDefault = score }
                default: if score > maxScore.inHard { self.maxScore.inHard = score }
            }
            self.score = 0
            self.lives = 9
            self.isLose = false
        }
    }
    @Published var isWin : Bool = false {
        didSet {
            if isWin == true {
                generarPalabra()
                score += 1
                isWin = false
            }
        }
    }
    
    @Published var word : String = ""
    @Published var displayedWord : String = ""
    @Published var letter : String = "" {
        didSet {
            guard letter.count != 0 else { return }
            let newChar = String(letter[String.Index(utf16Offset: (letter.count-1), in: letter)])
            self.checarLetra(newChar: newChar)
            if CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/checkIfWin.py '\(self.displayedWord)'`") == "win" {
                isWin = true
            }
        }
    }
    
    func getModeMaxScore(_ mode : GameDifficulty? = nil) -> String {
        switch mode ?? self.difficulty {
        case .inDefault:
            return String(self.maxScore.inDefault)
        case .inEasy:
            return String(self.maxScore.inEasy)
        case .inHard:
            return String(self.maxScore.inHard)
        }
    }
    
    init(noPython : Bool = false) {
        if !noPython {
            if CommandRunner.execResult("cd \(NSHomeDirectory())/Library/Application\\ Support/; [ -d 'AOX0' ] && echo 'Exists.' || echo 'Error'").contains("Error") {
                EnvObject.makeDefaultData()
            }
            
            let dificulty : String = CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) '\(Bundle.main.bundlePath)/Contents/Resources/getDifficulty.py' '\(NSHomeDirectory())'`")
                
            switch dificulty {
                case "default": self.difficulty = .inDefault
                case "easy": self.difficulty = .inEasy
                default: self.difficulty = .inHard
            }
            self.maxScore = EnvObject.getMaxScore()
        } else {
            self.maxScore = MaxScore(inEasy: 0, inDefault: 0, inHard: 0)
        }
    }
    
    
    public func generarPalabra() {
        self.letter = ""
        self.word = CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/genWord.py '\(NSHomeDirectory())' '\(self.difficulty.passDifficulty())'`")
        
        self.displayedWord = CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/genDisplayedWord.py '\(self.word.lowercased())' '\(self.difficulty.passDifficulty())'`")
        
    }
    
    public func checarLetra(newChar: String) {
        let wordBefore = self.displayedWord
        self.displayedWord = CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/checkWord.py '\(self.word.lowercased())' '\(newChar.lowercased())' '\(self.displayedWord)'`")
        
        if wordBefore == self.displayedWord {
            lives -= 1
        }
    }
    
    static func getMaxScore() -> MaxScore {
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
    
    func setDificulty() {
        CommandRunner.voidExec("cd \(NSHomeDirectory()); echo `\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/setDifficulty.py '\(NSHomeDirectory())' '\(self.difficulty.passDifficulty())'`")
    }

    public static func makeDefaultData() {
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/; mkdir AOX0")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/AOX0; touch save.json")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/AOX0; less \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/File.txt > save.json")
    }
    
    func setMaxScore() {
        switch self.difficulty {
            case .inEasy:
                CommandRunner.voidExec("\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/setMaxScore.py '\(NSHomeDirectory())' '\(maxScore.inEasy)' '\(difficulty.passDifficulty())'")
            case .inDefault:
                CommandRunner.voidExec("\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/setMaxScore.py '\(NSHomeDirectory())' '\(maxScore.inDefault)' '\(difficulty.passDifficulty())'")
            default:
                CommandRunner.voidExec("\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/setMaxScore.py '\(NSHomeDirectory())' '\(maxScore.inHard)' '\(difficulty.passDifficulty())'")
        }
    }
}

