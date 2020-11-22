//
//  DifficultyPicker.swift
//  Ahorcado
//
//  Created by Alejandro D on 22/11/20.
//

import SwiftUI

struct DifficultyPicker: View {
    @EnvironmentObject var data : EnvObject
    var subGeo : GeometryProxy
    
    let pickerOptions = [
        "1": GameDifficulty.inEasy,
        "2": GameDifficulty.inDefault,
        "3": GameDifficulty.inHard
    ]
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1..<4) { value in
                if data.difficulty != pickerOptions["\(value)"]! {
                    Image("slice\(value)").resizable()
                        .pickerButton(geo: subGeo, text: pickerOptions["\(value)"]!.passDifficulty().capitalized) {
                            data.difficulty = pickerOptions["\(value)"]!
                        }
                } else {
                    Image("slice\(value+3)").resizable()
                        .pickerButton(geo: subGeo, text: pickerOptions["\(value)"]!.passDifficulty().capitalized) {}
                }
            }
        }
    }
}
