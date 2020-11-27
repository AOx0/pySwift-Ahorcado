//
//  AhorcadoApp.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
// "\()\n"

import SwiftUI

@main
struct AhorcadoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var is_P = true
    @Environment(\.openURL) var openURL
    
    let envObj : EnvObject
    let bugObj : DebbugerObj
    
    init() {
        
        if CommandRunner.searchPy3() != "" {
            CommandRunner.pyPath = String(CommandRunner.searchPy3())
            self.envObj = EnvObject()
        } else {
            self.envObj = EnvObject(noPython: true)
        }
        
        
        self.bugObj = DebbugerObj()
        self.bugObj.debuggerText += "func: \(NSHomeDirectory())\n"
        self.bugObj.debuggerText += "\(CommandRunner.pyPath.parsedPath)\n"
        self.bugObj.debuggerText += "\(Bundle.main.bundlePath.parsedPath)\n"
        print(CommandRunner.pyPath.parsedPath)
        print(Bundle.main.bundlePath.parsedPath)
        
    }
    
    var body: some Scene {
        WindowGroup {
            if CommandRunner.searchPy3() != "" {
                ContentView()
                    .environmentObject(envObj)
                    .environmentObject(bugObj)
            } else {
                ZStack{}
                    .alert(isPresented: $is_P, content: {
                        Alert.init(title: Text("Imposible ejecutar"), message: Text("Python 3 no encontrado en /Library/Frameworks/Python.framework/Versions.\nInstale Python 3 y vuelva a intentar."), primaryButton: .default(Text("Ok"), action: {exit(0)}), secondaryButton: .default(Text("Install Python"), action: {
                            openURL(URL(string: "https://www.python.org/downloads/")!)
                        }))
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

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
