//
//  GameView.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var data : EnvObject
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Text("Lives: \(data.lives)")
                            .font(.system(size: 25))
                        Text("Score: \(data.score)")
                            .font(.system(size: 25))
                    }
                    .foregroundColor(.black)
                    .padding()
                    Spacer()
                }
                VStack (alignment: .center) {
                    Text("\(data.displayedWord)")
                        .foregroundColor(.black)
                        .font(.system(size: geo.size.height > geo.size.width ? geo.size.width * 0.15: geo.size.height * 0.15))
                    TextField("", text: $data.letter)
                        .multilineTextAlignment(.center)
                        .gameTextField()
                        .frame(width: geo.size.width/3)
                        .padding()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .ignoresSafeArea(edges: .all)
        }
        .alert(isPresented: $data.showLoseMessage) {
            Alert(title: Text("GameOver"), message: Text("You lost all your lives :'D\nScore: \(data.score)"), primaryButton: .default(Text("Retry"), action: {data.showLoseMessage.toggle()}), secondaryButton: .default(Text("Exit"), action: {data.showLoseMessage.toggle(); data.stage = .inMenu}))
        }
    }
}
