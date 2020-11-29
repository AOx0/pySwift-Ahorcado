//
//  ContentView.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI

extension Color{
    static var background = Color("ColorDeFondo")
}

struct ContentView: View {
    @EnvironmentObject var data : EnvObject
    @EnvironmentObject var dataHandler : DataHandler
    
    @SceneBuilder
    var body: some View {
        GeometryReader { geo in
            LinearGradient(gradient: Gradient(colors: [Color.background, Color.white]), startPoint: .bottomTrailing, endPoint: .topLeading)
                .edgesIgnoringSafeArea(.all)
            
            switch data.stage {
                case .inGame:
                    GameView()
                        .stageViewMode(geo: geo, envObject: data)
                        .edgesIgnoringSafeArea(.bottom)
                case .inSettings:
                    SettingsView()
                        .stageViewMode(geo: geo, envObject: data)
                default:
                    MainMenu()
                        .stageViewMode(geo: geo, envObject: data)
            }
            
            if dataHandler.debugger.isEnabled {
                Text("\(dataHandler.debugger.debuggerText)")
                    .font(.system(size: 10))
                    .foregroundColor(.red)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .bottomLeading)
            }
        }
        .frame(minWidth: 800, idealWidth: 800, maxWidth: .infinity*1.6, minHeight: 450, idealHeight: 450, maxHeight: (.infinity/2)*1.6, alignment: .center)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
