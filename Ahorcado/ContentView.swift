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
        }
        .frame(minWidth: 800, idealWidth: 800, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 450, idealHeight: 450, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
        
    }
}

struct StageView : ViewModifier {
    var geo : GeometryProxy
    var data : EnvObject
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .ignoresSafeArea(edges: .all)
            
            if data.stage != .inMenu {
                VStack{
                    HStack{
                        Image("BackButton").resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .onTapGesture {
                                
                                if data.stage == .inGame{
                                    data.score = 0
                                    data.vidas = 9
                                }
                                
                                withAnimation {
                                    data.stage = .inMenu
                                }
                            }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func stageViewMode(geo: GeometryProxy, envObject: EnvObject) -> some View {
        self.modifier(StageView(geo: geo, data: envObject))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
