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
            case .inDefault: return "deafult"
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
    @Published var dificultad = GameDifficulty.inDefault {
        didSet {
            self.setDificulty()
        }
    }
    
    @Published var vidas : Int = 4
    @Published var maxScore : Int = 0
    @Published var score : Int = 0
    
    @Published var isWin : Bool = false {
        didSet {
            if isWin == true {
                generarPalabra()
            }
        }
    }
    
    @Published var palabra : String = ""
    @Published var palabraParaUsuario : String = ""
    @Published var letra : String = "" {
        didSet {
            
            if letra.count == 1 {
                self.checarLetra(letra: letra)
                letra = ""
                
                if CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/checkIfWin.py '\(self.palabraParaUsuario)'`") == "win" {
                    isWin = true
                }
            }
        }
    }
    
    struct JSONStruct: Codable {
        var palabras: [String]
        var vidas: Int
    }
    
    public func generarPalabra() {
        self.palabra = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/genWord.py '\(NSHomeDirectory())' '\(self.dificultad.passDifficulty())'`")
        print(self.palabra)
        
        self.palabraParaUsuario = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/genQuestWord.py '\(self.palabra.lowercased())'`")
        
        print(self.palabraParaUsuario)
    }
    
    public func checarLetra(letra: String) {
        self.palabraParaUsuario = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/checkWord.py '\(self.palabra.lowercased())' '\(self.letra.lowercased())' '\(self.palabraParaUsuario)'`")
    }
    
    public func readData() {
        func getDificulty() {
            let dificulty : String = CommandRunner.execResult("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/getDifficulty.py '\(NSHomeDirectory())'`")
            
            switch dificulty {
                case "default": self.dificultad = .inDefault
                case "easy": self.dificultad = .inEasy
                default: self.dificultad = .inHard
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
        CommandRunner.voidExec("echo `python3 \(Bundle.main.bundlePath)/Contents/Resources/setDifficulty.py '\(NSHomeDirectory())' '\(self.dificultad.passDifficulty())'`")
    }

    public func makeDefaultData() {
        print("Creando...")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/; mkdir AOX0")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/AOX0; touch save.json")
        CommandRunner.voidExec("cd \(NSHomeDirectory())/Library/Application\\ Support/AOX0; less \(Bundle.main.bundlePath)/Contents/Resources/File.txt > save.json")
        print("Listo.")
    }
}

