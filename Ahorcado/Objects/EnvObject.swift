//
//  DataObject.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//



import Foundation

class EnvObject : ObservableObject {
    
    // Stage in the game
    @Published var stage : GameStage = GameStage.inMenu
    
    // Game's difficulty
    @Published var difficulty = GameDifficulty.inDefault { didSet{ DataHandler.setDificulty(difficulty: self.difficulty.passDifficulty()) } }
    
    // Win / Lose actions
    @Published var isLose : Bool = false { didSet{ gameLostActions() } }
    @Published var isWin : Bool = false { didSet{ gameWonActions() } }
    
    @Published var showLoseMessage : Bool = false
    @Published var lives : Int = 9 { didSet{ analizeIfLost() } }
    
    // Score
    @Published var score : Int = 0
    @Published var maxScore : MaxScore { didSet{ DataHandler.setMaxScore(difficulty: self.difficulty, maxScore: self.maxScore) } }
    
    // In-game variables
    @Published var word : String = ""
    @Published var displayedWord : String = ""
    @Published var letter : String = "" { didSet{ checkWrittenLetter() } }
    
    init(pythonIsInstalled : Bool) {
        if pythonIsInstalled {
            if DataHandler.saveDoesNotExists() { DataHandler.makeDefaultData() }
            self.difficulty = DataHandler.getDifficulty()
            self.maxScore = DataHandler.getMaxScore()
        } else {
            self.maxScore = MaxScore(inEasy: 0, inDefault: 0, inHard: 0)
        }
    }
}

