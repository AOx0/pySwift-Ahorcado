//
//  AhorcadoApp.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI
import Cocoa


func searchPy3() -> String {
    shSearchForPython()
    var pythonPath = CommandRunner.execute(pyShell: "/bin/cat", arguments: ["\(NSHomeDirectory())/tempㄦ∴.txt"]) ?? ""
    pythonPath = pythonPath.replacingOccurrences(of: "∴", with: "")
    pythonPath = pythonPath.replacingOccurrences(of: "\n", with: "")
    if pythonPath != "" { CommandRunner.voidExec("rm -f \(NSHomeDirectory())/tempㄦ∴.txt", pythonPath) }
    
    return pythonPath
}

func initializeData(_ obj : EnvObject) {
    if CommandRunner.execResult("cd \(NSHomeDirectory())/Library/Application\\ Support/; [ -d 'AOX0' ] && echo 'Exists.' || echo 'Error'").contains("Error") {
        obj.makeDefaultData()
    } else {
        obj.readData()
    }
}



@main
struct AhorcadoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var is_P = true
    
    let envObj : EnvObject
    
    init() {
        self.envObj = EnvObject()
        CommandRunner.pyPath = searchPy3()
        initializeData(envObj)
    }
    
    var body: some Scene {
        WindowGroup {
            if searchPy3() != "" {
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
