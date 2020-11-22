//
//  CommandRunner.swift
//  Ahorcado
//
//  Created by Alejandro D on 20/11/20.
//

import Foundation

struct CommandRunner {
    static var pyPath = ""
    
    static func execute(pyShell command: String, arguments: [String] = []) -> String? {
        let process = Process()
        process.launchPath = command
        process.arguments = arguments
        
        let pipe = Pipe()
        process.standardOutput = pipe
        if #available(OSX 10.13, *) {
            if let _ = try? process.run(){
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                let output = String(data: data, encoding: String.Encoding.utf8)
                return output
            }else{
                return "Error: \(process.terminationStatus)"
            }
        } else {
            return "Error: Only available in macOS 10.13 or newer"
        }
    }
    
    

    static func execResult(_ command: String, _ py : String = CommandRunner.pyPath) -> String {
        var result = execute(pyShell: py, arguments: ["-c", "import os; os.system(\"\(command)\")"]) ?? "Error"; if result.count > 0{ result.removeLast()}
        return result
    }

    static func printExec(_ command: String, _ py : String = CommandRunner.pyPath) {
        var result = execute(pyShell: py, arguments: ["-c", "import os; os.system(\"\(command)\")"]) ?? "Error"; if result.count > 0{ result.removeLast()}
        print(result)
    }
    
    static func voidExec(_ command: String, _ py : String = CommandRunner.pyPath) {
        _ = execute(pyShell: py, arguments: ["-c", "import os; os.system(\"\(command)\")"])
    }
    
}
