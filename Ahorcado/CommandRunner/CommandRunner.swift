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
        if let _ = try? process.run(){
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: String.Encoding.utf8)
            return output
        } else {
            return "Error: \(process.terminationStatus)"
        }
    }
    
    

    static func execResult(_ command: String, _ py : String = CommandRunner.pyPath.parsedPath) -> String {
        var result = execute(pyShell: py, arguments: ["-c", "import os; os.system(\"\(command)\")"]) ?? "Error"; if result.count > 0{ result.removeLast()}
        return result
    }

    static func printExec(_ command: String, _ py : String = CommandRunner.pyPath.parsedPath) {
        var result = execute(pyShell: py, arguments: ["-c", "import os; os.system(\"\(command)\")"]) ?? "Error"; if result.count > 0{ result.removeLast()}
        print(result)
    }
    
    static func voidExec(_ command: String, _ py : String = CommandRunner.pyPath.parsedPath) {
        _ = execute(pyShell: py, arguments: ["-c", "import os; os.system(\"\(command)\")"])
    }
    
    private static func searchNewestVersion(_ strWithVersions :  String) -> String {
        let strWithVersions = strWithVersions.replacingOccurrences(of: "/Library/Frameworks/Python.framework/Versions/", with: "").replacingOccurrences(of: "/bin/python3", with: "").replacingOccurrences(of: "/bin/python4", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "∴", with: " ")
        var listOfVersions : [Float32] = []
        var tempValue : String = ""
        for i in strWithVersions{
            if i == " " {
                listOfVersions.append(Float32(tempValue)!)
                tempValue = ""
            } else {
                tempValue += String(i)
            }
        }
        let newestVersion = String(listOfVersions.max()!)
        let gralNewestVersion = newestVersion[String.Index(utf16Offset: 0, in: newestVersion)]
        let newestVersionPath = "/Library/Frameworks/Python.framework/Versions/\(newestVersion)/bin/python\(gralNewestVersion)"
        
        return newestVersionPath
    }
    
    static func searchPy3() -> String {
        
        shSearchForPython2(NSHomeDirectory())
        var pythonPath = CommandRunner.execute(pyShell: "/bin/cat", arguments: ["\(NSHomeDirectory())/tempㄦ∴.txt"]) ?? ""
        var strNumberOfResults : String = ""
        var numberOfResults : Int = 0
        
        for i in pythonPath {
            if i == ":" {
                numberOfResults = Int(String(strNumberOfResults).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")) ?? 0
                pythonPath = pythonPath.replacingOccurrences(of: "\(strNumberOfResults):", with: "")
                break;
            } else {
                strNumberOfResults += String(i)
            }
        }
        
        pythonPath = pythonPath.replacingOccurrences(of: "\n", with: "")
        
        if numberOfResults == 1 {
            pythonPath = pythonPath.replacingOccurrences(of: "∴", with: "")
        } else if numberOfResults > 1 {
            pythonPath = CommandRunner.searchNewestVersion(pythonPath)
        } else if numberOfResults == 0 {
            pythonPath = ""
        }
        
        if pythonPath != "" { CommandRunner.voidExec("rm -f \(NSHomeDirectory())/tempㄦ∴.txt", pythonPath) }
        
        return pythonPath
    }
}
