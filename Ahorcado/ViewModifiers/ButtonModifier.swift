//
//  ButtonModifier.swift
//  Ahorcado
//
//  Created by Alejandro D on 27/11/20.
//

import SwiftUI

struct ButtonModifier : ViewModifier {
    let action : () -> ()
    func body(content: Content) -> some View {
        content

            .shadow(radius: 20)
            .foregroundColor(.black)
            .padding(5)
            .padding([.horizontal], 20.0)
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(.black)
                    .opacity(0.1)
                    .shadow(radius: 20)
            )
            .onTapGesture {
                action()
            }
        
    }
}
