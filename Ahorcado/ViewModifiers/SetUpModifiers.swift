//
//  SetUpModifiers.swift
//  Ahorcado
//
//  Created by Alejandro D on 22/11/20.
//

import SwiftUI

extension View {
    func gameTextField() -> some View {
        self.modifier(TextFieldModifier())
    }
    
    func gameButton(action : @escaping () -> ()) -> some View {
        self.modifier(ButtonModifier(action: action))
    }
    
    func menuButton(action: @escaping () -> ()) -> some View {
        self.modifier(MenuButtonModifier(action: action))
    }
    
    func pickerButton(geo : GeometryProxy, text: String,  action : @escaping () -> ()) -> some View {
        self.modifier(CustomPickerModifier(subGeo: geo, text: text, action: action))
        
    }
    
    func stageViewMode(geo: GeometryProxy, envObject: EnvObject) -> some View {
        self.modifier(StageView(geo: geo, data: envObject))
    }
}
