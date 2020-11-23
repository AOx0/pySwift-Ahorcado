//
//  DataObject.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import Foundation

struct MaxScore: Codable {
    var inEasy: Int
    var inDefault: Int
    var inHard: Int
    
    func setMaxScore(difficulty : GameDifficulty) {
        switch difficulty {
            case .inEasy:
                CommandRunner.voidExec("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/setMaxScore.py '\(NSHomeDirectory())' '\(self.inEasy)' '\(difficulty.passDifficulty())'`")
            case .inDefault:
                CommandRunner.voidExec("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/setMaxScore.py '\(NSHomeDirectory())' '\(self.inDefault)' '\(difficulty.passDifficulty())'`")
            default:
                CommandRunner.voidExec("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/setMaxScore.py '\(NSHomeDirectory())' '\(self.inHard)' '\(difficulty.passDifficulty())'`")
        }
    }
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
    @Published var showLoseMessage : Bool = false
    
    @Published var stage : GameStage = GameStage.inMenu
    @Published var difficulty = GameDifficulty.inDefault {
        didSet {
            self.setDificulty()
        }
    }
    
    @Published var lives : Int = 4 {
        didSet {
            if self.lives == 0 {
                isLose = true
                showLoseMessage = true
            }
        }
    }
    @Published var maxScore : MaxScore = MaxScore(inEasy: 0, inDefault: 0, inHard: 0) {
        didSet {
            maxScore.setMaxScore(difficulty: difficulty)
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
            
            if letter.count == 1 {
                self.checarLetra(letter: letter)
                letter = ""
                
                if CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/checkIfWin.py '\(self.displayedWord)'`") == "win" {
                    isWin = true
                }
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
    
    func initializeData() {
        if CommandRunner.execResult("cd \(NSHomeDirectory())/Library/Application\\ Support/; [ -d 'AOX0' ] && echo 'Exists.' || echo 'Error'").contains("Error") {
            self.makeDefaultData()
        } else {
            self.readData()
        }
    }
    
    public func generarPalabra() {
        self.word = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/genWord.py '\(NSHomeDirectory())' '\(self.difficulty.passDifficulty())'`")
        print(self.word)
        
        self.displayedWord = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/genDisplayedWord.py '\(self.word.lowercased())' '\(self.difficulty.passDifficulty())'`")
        
        print(self.displayedWord)
    }
    
    public func checarLetra(letter: String) {
        let wordBefore = self.displayedWord
        self.displayedWord = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/checkWord.py '\(self.word.lowercased())' '\(self.letter.lowercased())' '\(self.displayedWord)'`")
        
        if wordBefore == self.displayedWord {
            lives -= 1
        }
    }
    
    public func readData() {
        func getDificulty() {
            let dificulty : String = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/getDifficulty.py '\(NSHomeDirectory())'`")
            
            switch dificulty {
                case "default": self.difficulty = .inDefault
                case "easy": self.difficulty = .inEasy
                default: self.difficulty = .inHard
            }
        }
        
        func getMaxScore() {
            let maxScore : String = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/getMaxScore.py '\(NSHomeDirectory())'`")
            //self.maxScore = maxScore
            let jsonData = maxScore.data(using: .utf8)!
            self.maxScore = try! JSONDecoder().decode(MaxScore.self, from: jsonData)
            print(self.maxScore)
        }
        
        getMaxScore()
        getDificulty()
    }
    
    func setDificulty() {
        CommandRunner.voidExec("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/setDifficulty.py '\(NSHomeDirectory())' '\(self.difficulty.passDifficulty())'`")
    }

    public func makeDefaultData() {
        print("Creando...")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/; mkdir AOX0")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/AOX0; touch save.json")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/AOX0; less \(Bundle.main.bundlePath)/Contents/Resources/File.txt > save.json")
        print("Listo.")
    }
}

