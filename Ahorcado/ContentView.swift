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
    @EnvironmentObject var debugger : DebbugerObj
    
    @SceneBuilder
    var body: some View {
        GeometryReader { geo in
            LinearGradient(gradient: Gradient(colors: [Color.background, Color.white]), startPoint: .bottomTrailing, endPoint: .topLeading)
                .edgesIgnoringSafeArea(.all)
            
            switch data.stage {
                case .inGame:
                    GameView()
                        .stageViewMode(geo: geo, envObject: data)
                case .inSettings:
                    SettingsView()
                        .stageViewMode(geo: geo, envObject: data)
                default:
                    MainMenu()
                        .stageViewMode(geo: geo, envObject: data)
            }
            
            if debugger.isEnabled {
                Text("\(debugger.debuggerText)")
                    .font(.system(size: 10))
                    .foregroundColor(.red)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .bottomLeading)
            }
        }
        .frame(minWidth: 800, idealWidth: 800, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 450, idealHeight: 450, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
