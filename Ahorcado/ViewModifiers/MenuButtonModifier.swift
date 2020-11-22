//
//  MenuButtonModifier.swift
//  Ahorcado
//
//  Created by Alejandro D on 22/11/20.
//

import SwiftUI

struct MenuButtonModifier : ViewModifier {
    let action : () -> ()
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50))
            .padding()
            .foregroundColor(.black)
            .ignoresSafeArea(edges: .all)
            .onTapGesture {
                action()
            }
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .border(Color.black, width: 1)
                    .opacity(0.0)
                    
            )
    }
}
