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
                    
                    Text("Max Score: \(data.maxScore)")
                        .foregroundColor(.black)
                    
                    Text("Play")
                        .font(.system(size: 50))
                        .padding()
                        .foregroundColor(.black)
                        .ignoresSafeArea(edges: .all)
                        .onTapGesture {
                            data.generarPalabra()
                            withAnimation {
                                data.stage = .inGame
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                .opacity(0.0)
                                
                        )
                    
                    Text("Settings")
                        .font(.system(size: 50))
                        .padding()
                        .foregroundColor(.black)
                        .ignoresSafeArea(edges: .all)
                        .onTapGesture {
                            withAnimation {
                                data.stage = .inSettings
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                .opacity(0.0)
                                
                        )
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .ignoresSafeArea(edges: .all)
        }
        
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu().environmentObject(EnvObject())
    }
}

