//
//  AppDelegate.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2019/12/2.
//  Copyright © 2019 eport2. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    var vc: ViewController?
    var window: NSWindow?
    var window1: NSWindow?
    var mainSession: NSApplication.ModalSession?
    var window1Session: NSApplication.ModalSession?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let sb = NSStoryboard(name: "Main", bundle: Bundle.main)
        vc = sb.instantiateController(withIdentifier: "ViewController") as? ViewController
        let wc = sb.instantiateController(withIdentifier: "Document Window Controller") as? NSWindowController
        window = wc?.window
        window?.delegate = self
//        shared?.mainSession = NSApplication.shared.beginModalSession(for: window!)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
//        for window in sender.windows {
//            NSApp.terminate(window)
//        }
        CommandWork.setVolumeMute()
        return true;
    }
    

    func windowWillClose(_ notification: Notification) {

//        alert?.runModal()
//        NSApp.runModal(for: (alert?.window)!)
    }
    
    lazy var alert: NSAlert? = {
        let alert = NSAlert()
        alert.alertStyle = .informational
        let btnCancel = alert.addButton(withTitle: "Cancel")
        btnCancel.action = #selector(btnCancelEvent(any:))
        btnCancel.target = self
        let btnOK = alert.addButton(withTitle: "OK")
        btnOK.action = #selector(btnOKEvent(any:))
        btnOK.target = self
        alert.messageText = "Really Exit App ?"
        return alert
    }()
    
    @objc func btnCancelEvent(any: Any) {
        
//        alert?.window.orderOut(nil)
//        NSApp.runModal(for: window!)
    }
    
    @objc func btnOKEvent(any: Any) {
        exit(0)
    }
}

