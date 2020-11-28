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
    @State var whenPythonNotInstalled = !CommandRunner.pythonIsInstalled
    @Environment(\.openURL) var openURL
    
    let envObj : EnvObject
    let handlerObj : DataHandler
    
    init() {
        self.handlerObj = DataHandler()
        
        if CommandRunner.pythonIsInstalled {
            self.handlerObj.debugger.debuggerText += "Normal Init...\n"
            CommandRunner.pyPath = String(CommandRunner.searchPy3())
            self.envObj = EnvObject(pythonIsInstalled: true)
        } else {
            self.handlerObj.debugger.debuggerText += "Anormal init...\n"
            self.envObj = EnvObject(pythonIsInstalled: false)
        }
        
        self.handlerObj.debugger.debuggerText += "User Path: \(NSHomeDirectory())\n"
        self.handlerObj.debugger.debuggerText += "Python Path: \(CommandRunner.pyPath.parsedPath)\n"
        self.handlerObj.debugger.debuggerText += "App path: \(Bundle.main.bundlePath.parsedPath)\n"
    }
    
    var body: some Scene {
        WindowGroup {
            if CommandRunner.pythonIsInstalled {
                ContentView()
                    .environmentObject(envObj)
                    .environmentObject(handlerObj)
            } else {
                ZStack{
                    Text("")
                        .opacity(0.0)
                        .disabled(true)
                }
                    .alert(isPresented: $whenPythonNotInstalled, content: {
                        noPythonAlert(openURL: openURL)
                    })
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

func noPythonAlert(openURL : OpenURLAction) -> Alert {
    Alert.init(
        title: Text("Imposible ejecutar"),
        message: Text("Python 3 no encontrado en /Library/Frameworks/Python.framework/Versions.\nInstale Python 3 de python.org y vuelva a intentar."),
        primaryButton: .default(
            Text("Ok"),
            action: {exit(0)}
        ),
        secondaryButton: .default(
            Text("Install Python"),
            action: {openURL(URL(string: "https://www.python.org/downloads/")!)}
        )
    )
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
