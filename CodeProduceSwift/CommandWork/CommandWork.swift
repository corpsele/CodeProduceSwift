//
//  CommandWork.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2021/1/18.
//  Copyright © 2021 eport2. All rights reserved.
//

import Cocoa
import SwiftShell

class CommandWork: NSObject {
    
    func doWork() {
        
    }
    
    public func checkWifi() -> Bool {
        var isOpened = false
//        let cmd = "/bin/sh"
//        let arguments: [String] = ["/Users/eport2/Documents/openwifi.sh"]
//        let task = Process.launchedProcess(launchPath: cmd, arguments: arguments)
//        do {
//            try task.run()
//        } catch let err {
//            print(err)
//            isOpened = false
//        }
        
//        let state = shell(command: "")
//
//        print(state)
//        var err: NSDictionary? = [:]
//        let _ = NSAppleScript(source: "do shell script \"/Users/eport2/Documents/systemp\" with administrator privileges user name \"eport2\" password \"eport\"")?.executeAndReturnError(&err)
//        print(err)
        
//        let _ = NSAppleScript.init(source: "do shell script \"sudo networksetup -setairportpower Wi-Fi off\" with administrator " +
//                                    "privileges")?.executeAndReturnError(nil)
//        do {
//            try runAndPrint(bash: "networksetup -setairportpower Wi-Fi off")
//        } catch let err {
//            print(err)
//        }
        
        
        return isOpened
    }
    
    static func openWifi() {
//        let _ = shell(command: "open /Users/eport2/Documents/openwifi.app")
        var err: NSDictionary? = [:]
        let str = "tell application \"/Users/eport2/Documents/openwifi.app\" \n end tell"
        print(str)
        let appleScript = NSAppleScript(source: str)
        if let flag = appleScript?.compileAndReturnError(&err) {
            if flag {
                let event = appleScript?.executeAndReturnError(&err)
                if err?.allKeys.count != 0 {
                    let alert = NSAlert()
                    guard let str = err?["NSAppleScriptErrorMessage"] as? String else {
                        print(err)
                        
                        return
                    }
                    alert.messageText = str
                    alert.runModal()
                }
                if let flag = appleScript?.isCompiled {
                    if flag {
                        print("finish")
                    }
                }
                print(err)
            }
        }

    }
    
    static func closeWifi() {
//        let _ = shell(command: "open /Users/eport2/Documents/closewifi.app")
        var err: NSDictionary? = [:]
        let str = "tell application \"/Users/eport2/Documents/closewifi.app\" \n end tell"
//        let _ = NSAppleScript(source: str)?.executeAndReturnError(&err)
        let appleScript = NSAppleScript(source: str)
        if let flag = appleScript?.compileAndReturnError(&err) {
            if flag {
                let event = appleScript?.executeAndReturnError(&err)
                if err?.allKeys.count != 0 {
                    let alert = NSAlert()
                    guard let str = err?["NSAppleScriptErrorMessage"] as? String else {
                        print(err)
                        
                        return
                    }
                    alert.messageText = str
                    alert.runModal()
                }
                if let flag = appleScript?.isCompiled {
                    if flag {
                        print("finish")
                    }
                }
                print(err)
            }
        }
    }
    
    static func connectCLWifi() {
        var err: NSDictionary? = [:]
        let str = "tell application \"/Users/eport2/Documents/connectclwifi.app\" \n end tell"
        let appleScript = NSAppleScript(source: str)
        if let flag = appleScript?.compileAndReturnError(&err) {
            if flag {
                let event = appleScript?.executeAndReturnError(&err)
                if err?.allKeys.count != 0 {
                    let alert = NSAlert()
                    guard let str = err?["NSAppleScriptErrorMessage"] as? String else {
                        print(err)
                        
                        return
                    }
                    alert.messageText = str
                    alert.runModal()
                }
                if let flag = appleScript?.isCompiled {
                    if flag {
                        print("finish")
                    }
                }
                print(err)
            }
        }
    }
    
    func shell(command: String) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["bash", "-c", command]
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }

}
