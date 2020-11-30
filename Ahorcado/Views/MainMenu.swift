//
//  MainMenu.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI

struct MainMenu: View {
    @EnvironmentObject var data : EnvObject
    @State var playHover : Bool = false
    @State var settingsHover : Bool = false
    @State var exitHover : Bool = false
        
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("Background").resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(0)
                    .ignoresSafeArea(edges: .bottom)
                    .frame(alignment: Alignment.bottomTrailing)
                
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
                        .onHover { hover in
                            playHover = hover
                        }
                        .opacity(playHover ? 1 : 0.8)
                    
                    Text("Settings")
                        .menuButton {
                            withAnimation {
                                data.stage = .inSettings
                            }
                        }
                        .onHover { hover in
                            settingsHover = hover
                        }
                        .opacity(settingsHover ? 1 : 0.8)
                    Text("Exit")
                        .menuButton {
                            GameMusicPlayer.stopSound()
                            exit(0)
                        }
                        .onHover { hover in
                            exitHover = hover
                        }
                        .opacity(exitHover ? 1 : 0.8)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .ignoresSafeArea(edges: .all)
        }
    }
}
