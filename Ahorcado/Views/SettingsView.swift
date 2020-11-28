//
//  WordView.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var data : EnvObject
    @EnvironmentObject var debbuger : DebbugerObj
    
    @State var showAddWordHelp : Bool = false
    @State var showDifficultyHelp : Bool = false
    
    @State var newWord = ""
    let pickerOptions = [
        "1": GameDifficulty.inEasy,
        "2": GameDifficulty.inDefault,
        "3": GameDifficulty.inHard
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Text("Settings")
                        .bold()
                        .foregroundColor(.black)
                        .font(.system(size: 70))
                        .padding()
                        .onLongPressGesture {
                            debbuger.isEnabled.toggle()
                        }
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("Difficulty : ")
                                .foregroundColor(.black)
                                .font(.system(size: 25))
                            Spacer()
                            Image("Help").resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .onHover(perform: { hovering in
                                    showDifficultyHelp = hovering
                                })
                                .popover(isPresented: $showDifficultyHelp, content: {
                                    Text("Cada dificultad del juego tiene su propio score máximo:\n\t- Fácil: 1 letra censurada minimo. Palabras cortas y con muchas vocales\n\t-Default: 80% de la palabrea censurada minimo. Mezcla de palabras estandard con féciles.\n\t-Dificil:  100% censurado. Incluye palabras faciles y estandard así como palabras inusuales y largas.")
                                        .multilineTextAlignment(.leading)
                                        .frame(width: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .padding()
                                })
                        }
                        
                        GeometryReader { subGeo in
                            DifficultyPicker(subGeo: subGeo)
                        }
                        .frame(width: 200, height: 20, alignment: .center)
                        
                        VStack(spacing: 0) {
                            Text("Max Score (\(GameDifficulty.inEasy.passDifficulty().capitalized)): \t\(data.getModeMaxScore(GameDifficulty.inEasy))")
                                .foregroundColor(.black)
                            Text("Max Score (\(GameDifficulty.inDefault.passDifficulty().capitalized)): \t\(data.getModeMaxScore(GameDifficulty.inDefault))")
                                .foregroundColor(.black)
                            Text("Max Score (\(GameDifficulty.inHard.passDifficulty().capitalized)): \t\(data.getModeMaxScore(GameDifficulty.inHard))")
                                .foregroundColor(.black)
                        }
                        .padding(.all, 10.0)
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .opacity(0.1)
                                .shadow(radius: 20)
                                .frame(width: 200, alignment: .center)
                        )
                        
                        Divider()
                            .colorMultiply(.black)
                        
                        HStack(alignment: .center) {
                            Text("Add Words : ")
                                .foregroundColor(.black)
                                .font(.system(size: 25))
                            Spacer()
                            Image("Help").resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .onHover(perform: { hovering in
                                    showAddWordHelp = hovering
                                })
                                .popover(isPresented: $showAddWordHelp, content: {
                                    Text("Al añadir una palabra se calculará su grado de dificultad y se agregará a la categoría inidcada. No se pueden borrar palabras añadidas")
                                        .multilineTextAlignment(.leading)
                                        .frame(width: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .padding()
                                })
                        }
                        
                        VStack(spacing: 0) {
                            TextField("", text: $newWord)
                                .gameTextField()
                            Text("Add Word")
                                .gameButton {
                                    CommandRunner.voidExec("\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/addWord.py '\(NSHomeDirectory())' '\(newWord)'")
                                }
                        }
                        .padding(.all, 10.0)
                        
                        Divider()
                            .colorMultiply(.black)
                            .padding(.bottom, 10.0)
                        
                        HStack {
                            Text("Reset All")
                                .gameButton {
                                    EnvObject.makeDefaultData()
                                    let dificulty : String = CommandRunner.execResult("echo `\(CommandRunner.pyPath.parsedPath) '\(Bundle.main.bundlePath)/Contents/Resources/getDifficulty.py' '\(NSHomeDirectory())'`")
                                        
                                    switch dificulty {
                                        case "default": data.difficulty = .inDefault
                                        case "easy": data.difficulty = .inEasy
                                        default: data.difficulty = .inHard
                                    }
                                    data.maxScore = EnvObject.getMaxScore()
                                }
                            Text("Reset Added Words")
                                .gameButton {
                                    CommandRunner.voidExec("\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/resetUserWords.py '\(NSHomeDirectory())'")
                                }
                            
                            Text("Reset Max Score")
                                .gameButton {
                                    CommandRunner.voidExec("\(CommandRunner.pyPath.parsedPath) \(Bundle.main.bundlePath.parsedPath)/Contents/Resources/resetMaxScore.py '\(NSHomeDirectory())'")
                                    data.maxScore = EnvObject.getMaxScore()
                                }
                            
                        }
                        .frame(width: geo.size.width, height: 20, alignment: .center)
                       
                            
                    }
                    .frame(width: 350, height: 20, alignment: .center)
                    
                    
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


