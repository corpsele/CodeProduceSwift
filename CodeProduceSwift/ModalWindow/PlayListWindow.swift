//
//  PlayListWindow.swift
//  CodeProduceSwift
//
//  Created by eport on 2025/3/3.
//  Copyright © 2025 eport2. All rights reserved.
//

class PlayListWindow: NSWindow, NSWindowDelegate {
    var screenFrame: CGRect? = .zero
    var windowX, windowY: CGFloat?
    
    init() {
        let rect = NSRect(x: 980.0, y: 0.0, width: 640.0, height: 480.0)
        super.init(contentRect: rect, styleMask: .docModalWindow, backing: .buffered, defer: false)
        
        //        setFrame(NSRect(x: screen?.frame.width ?? 22 / 2, y: screen?.frame.height ?? 22 / 2 + 50.0, width: 50.0, height: 50.0), display: true, animate: true)
        
        initViews()
    }
    
    private func initViews(){
        
    }
}
