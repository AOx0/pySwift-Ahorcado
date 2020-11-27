//
//  TextFieldModifier.swift
//  Ahorcado
//
//  Created by Alejandro D on 27/11/20.
//

import SwiftUI

struct TextFieldModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .colorMultiply(.black)
            .accentColor(.black)
            .foregroundColor(.black)
            .textFieldStyle(PlainTextFieldStyle())
            .padding(5)
            .padding([.horizontal], 20.0)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .opacity(0.1)
                    .shadow(radius: 10)
                    
            )
            .padding(.bottom, 10)
    }
}

