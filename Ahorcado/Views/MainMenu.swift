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
                        .menuButton {
                            data.generarPalabra()
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
