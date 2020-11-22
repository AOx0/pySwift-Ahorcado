//
//  AhorcadoApp.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI

@main
struct AhorcadoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var is_P = true
    
    let envObj : EnvObject
    
    init() {
        self.envObj = EnvObject()
        CommandRunner.pyPath = CommandRunner.searchPy3()
        envObj.initializeData()
    }
    
    var body: some Scene {
        WindowGroup {
            if CommandRunner.searchPy3() != "" {
                ContentView()
                    .environmentObject(envObj)
            } else {
                ZStack{}
                    .alert(isPresented: $is_P, content: {
                        Alert.init(title: Text("Imposible ejecutar"), message: Text("Python 3 no encontrado.\nInstale Python 3 y vuelva a intentar."), dismissButton: .default(Text("Ok"), action: {exit(0)}))
                    })
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
