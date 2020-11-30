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
                switch data.lives {
                case 9:
                    Image("part0").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                    
                case 8:
                    Image("part1").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                case 7:
                    Image("part2").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                case 6:
                    Image("part3").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                case 5:
                    Image("part4").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                case 4:
                    Image("part5").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                case 3:
                    Image("part6").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                case 2:
                    Image("part7").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                case 1:
                    Image("part8").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                case 0:
                    Image("part9").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                default:
                    Image("part0").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .ignoresSafeArea(edges: .bottom)
                        .frame(alignment: Alignment.bottomTrailing)
                }
                
                if data.score == 0 && data.letter == "" && data.lives == 9 {
                    VStack {
                        Text("¿Cuantás palabras puedes adivinar con solo 9 vidas?")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .padding()
                        Spacer()
                    }
                }
                
                
                HStack {
                    VStack {
                        Spacer()
                        Text("Lives: \(data.lives)")
                            .font(.system(size: 30))
                        Text("Score: \(data.score)")
                            .font(.system(size: 30))
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
        .ignoresSafeArea(edges: .all)
        .alert(isPresented: $data.showLoseMessage) {
            Alert(title: Text("GameOver"), message: Text("You lost all your lives :'D\nScore: \(data.score)"), primaryButton: .default(Text("Retry"), action: {data.showLoseMessage.toggle();data.generateWord()}), secondaryButton: .default(Text("Exit"), action: {data.showLoseMessage.toggle(); data.stage = .inMenu}))
        }
        
    }
}
