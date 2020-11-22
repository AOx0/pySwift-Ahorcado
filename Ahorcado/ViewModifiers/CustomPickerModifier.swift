//
//  CustomPickerModifier.swift
//  Ahorcado
//
//  Created by Alejandro D on 22/11/20.
//

import SwiftUI

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
