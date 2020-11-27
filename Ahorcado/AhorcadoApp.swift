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
        self.bugObj = DebbugerObj()
        
        if CommandRunner.searchPy3() != "" {
            self.bugObj.debuggerText += "Normal Init...\n"
            CommandRunner.pyPath = String(CommandRunner.searchPy3())
            self.envObj = EnvObject()
        } else {
            self.bugObj.debuggerText += "Anormal init...\n"
            print("Anormal init...")
            self.envObj = EnvObject(noPython: true)
        }
        
        self.bugObj.debuggerText += "User Path: \(NSHomeDirectory())\n"
        self.bugObj.debuggerText += "Python Path: \(CommandRunner.pyPath.parsedPath)\n"
        self.bugObj.debuggerText += "App path: \(Bundle.main.bundlePath.parsedPath)\n"
    }
    
    var body: some Scene {
        WindowGroup {
            if CommandRunner.searchPy3() != "" {
                ContentView()
                    .environmentObject(envObj)
                    .environmentObject(bugObj)
            } else {
                ZStack{
                    Text("")
                        .opacity(0.0)
                        .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                }
                    .alert(isPresented: $is_P, content: {
                        Alert.init(title: Text("Imposible ejecutar"), message: Text("Python 3 no encontrado en /Library/Frameworks/Python.framework/Versions.\nInstale Python 3 de python.org y vuelva a intentar."), primaryButton: .default(Text("Ok"), action: {exit(0)}), secondaryButton: .default(Text("Install Python"), action: {
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
