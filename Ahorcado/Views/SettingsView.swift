//
//  WordView.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var data : EnvObject
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    VStack(spacing: 0) {
                        Text("Settings")
                            .bold()
                            .foregroundColor(.black)
                            .font(.system(size: 70))
                        
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(width: geo.size.width, height: 1, alignment: .center)
                            .hidden()
                    }
                    .padding()
                    Spacer()
                    
                    HStack {
                        Text("Difficulty : ")
                            .foregroundColor(.black)
                        GeometryReader { subGeo in
                            ZStack {
                                HStack(spacing: 0) {
                                    if data.dificultad != GameDifficulty.inEasy {
                                        Image("slice1").resizable()
                                            .pickerButton(geo: subGeo, text: "Easy") {
                                                data.dificultad = .inEasy
                                            }
                                    } else {
                                        Image("slice4").resizable()
                                            .pickerButton(geo: subGeo, text: "Easy") {}
                                    }
                                    
                                    Rectangle()
                                        .frame(width: 2, height: subGeo.size.height, alignment: .center)
                                        .foregroundColor(.black)
                                        .opacity(0.0)
                                    if data.dificultad != GameDifficulty.inDefault {
                                        Image("slice2").resizable()
                                            .pickerButton(geo: subGeo, text: "Default") {
                                                data.dificultad = .inDefault
                                            }
                                    } else {
                                        Image("slice5").resizable()
                                            .pickerButton(geo: subGeo, text: "Default") {}
                                    }
                                    Rectangle()
                                        .frame(width: 2, height: subGeo.size.height, alignment: .center)
                                        .foregroundColor(.black)
                                        .opacity(0.0)
                                    if data.dificultad != GameDifficulty.inHard {
                                        Image("slice3").resizable()
                                            .pickerButton(geo: subGeo, text: "Hard") {
                                                data.dificultad = .inHard
                                            }
                                    } else {
                                        Image("slice6").resizable()
                                            .pickerButton(geo: subGeo, text: "Hard") {}
                                    }
                                }
                                
                            }
                        }
                        .frame(width: 200, height: 20, alignment: .center)
                    }
                    
                    
                    
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .onTapGesture {
                            data.dificultad = .inHard
                            data.setDificulty()
                    }
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .ignoresSafeArea(edges: .all)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct CustomPickerModifier : ViewModifier {
    let subGeo : GeometryProxy
    let text : String
    let action : () -> ()
    
    func body(content: Content) -> some View {
        content
            .opacity(0.1)
            .frame(width: (subGeo.size.width/3), height: 20, alignment: .center)
            .overlay(
                Text(self.text)
                    .foregroundColor(.black)
            )
            .onTapGesture {
                action()
            }
    }
}

extension View {
    func pickerButton(geo : GeometryProxy, text: String,  action : @escaping () -> ()) -> some View {
        self.modifier(CustomPickerModifier(subGeo: geo, text: text, action: action))
        
    }
}
