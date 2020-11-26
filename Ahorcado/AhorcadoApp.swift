//
//  AhorcadoApp.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
// "\()\n"

import SwiftUI

var userHomeDirectoryPath : String {
    let pw = getpwuid(getuid())
    let home = pw?.pointee.pw_dir
    let homePath = FileManager.default.string(withFileSystemRepresentation: home!, length: Int(strlen(home!)))

    return homePath
}

@main
struct AhorcadoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var is_P = true
    
    let envObj : EnvObject
    
    init() {
        CommandRunner.pyPath = String(CommandRunner.searchPy3())
        self.envObj = EnvObject()
        self.envObj.debugMessage += "var:  \(userHomeDirectoryPath)\n"
        self.envObj.debugMessage += "func: \(NSHomeDirectory())\n"
        self.envObj.debugMessage += "\(CommandRunner.pyPath.parsedPath)\n"
        self.envObj.debugMessage += "\(Bundle.main.bundlePath.parsedPath)\n"
        print(CommandRunner.pyPath.parsedPath)
        print(Bundle.main.bundlePath.parsedPath)
        
    }
    
    var body: some Scene {
        WindowGroup {
            if CommandRunner.searchPy3() != "" {
                ContentView()
                    .environmentObject(envObj)
            } else {
                ZStack{}
                    .alert(isPresented: $is_P, content: {
                        Alert.init(title: Text("Imposible ejecutar"), message: Text("Python 3 no encontrado en /Library/Frameworks/Python.framework/Versions.\nInstale Python 3 y vuelva a intentar."), dismissButton: .default(Text("Ok"), action: {exit(0)}))
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
