//
//  WordView.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var data : EnvObject
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
                    Spacer()
                    
                    HStack {
                        Text("Difficulty : ")
                            .foregroundColor(.black)
                        GeometryReader { subGeo in
                            DifficultyPicker(subGeo: subGeo)
                        }
                        .frame(width: 200, height: 20, alignment: .center)
                    }

                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .onTapGesture {
                            data.difficulty = .inHard
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


