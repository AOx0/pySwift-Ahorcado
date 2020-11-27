//
//  DebbugerObj.swift
//  Ahorcado
//
//  Created by Alejandro D on 26/11/20.
//

import Foundation

class DebbugerObj : ObservableObject {
    @Published var debuggerText : String = ""
    @Published var isEnabled : Bool = false
}
