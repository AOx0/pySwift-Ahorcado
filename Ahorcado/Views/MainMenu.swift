//
//  MainMenu.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI

struct MainMenu: View {
    @EnvironmentObject var data : EnvObject
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Text("Ahorcado")
                        .bold()
                        .foregroundColor(.black)
                        .font(.system(size: 100))
                    
                    Text("Max Score (\(data.difficulty.passDifficulty().capitalized)): \(data.showMaxScoreOf(difficulty: data.difficulty))")
                        .foregroundColor(.black)
                    
                    Text("Play")
                        .bold()
                        .menuButton {
                            data.generateWord()
                            withAnimation {
                                data.stage = .inGame
                            }
                        }
                    
                    Text("Settings")
                        .menuButton {
                            withAnimation {
                                data.stage = .inSettings
                            }
                        }
                    Text("Exit")
                        .menuButton {
                            exit(0)
                        }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .ignoresSafeArea(edges: .all)
        }
    }
}
