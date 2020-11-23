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
                    
                    Text("Difficulty : ")
                        .foregroundColor(.black)
                        .font(.system(size: 25))
                    
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
                    )
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


