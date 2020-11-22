//
//  DataObject.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import Foundation

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
    @Published var stage : GameStage = GameStage.inMenu
    @Published var difficulty = GameDifficulty.inDefault {
        didSet {
            self.setDificulty()
        }
    }
    
    @Published var lifes : Int = 4
    @Published var maxScore : Int = 0
    @Published var score : Int = 0
    
    @Published var isWin : Bool = false {
        didSet {
            if isWin == true {
                generarPalabra()
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
    
    struct JSONStruct: Codable {
        var wordsList: [String]
        var lifes: Int
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
        
        self.displayedWord = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/genQuestWord.py '\(self.word.lowercased())'`")
        
        print(self.displayedWord)
    }
    
    public func checarLetra(letter: String) {
        self.displayedWord = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/checkWord.py '\(self.word.lowercased())' '\(self.letter.lowercased())' '\(self.displayedWord)'`")
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
            let maxScore : Int = Int(CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/getMaxScore.py '\(NSHomeDirectory())'`")) ?? 0
            self.maxScore = maxScore
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

