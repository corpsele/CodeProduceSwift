//
//  ModalWindow.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2020/12/7.
//  Copyright © 2020 eport2. All rights reserved.
//

import Cocoa

class ModalWindow: NSWindow, NSWindowDelegate {
    var screenFrame: CGRect? = .zero
    
    init() {
        let rect = NSRect(center: NSPoint.init(x: NSApp.keyWindow?.frame.width ?? 22 / 2 , y: NSApp.keyWindow?.frame.height ?? 22 / 2), size: CGSize(width: 50.0, height: 50.0))
        super.init(contentRect: rect, styleMask: .docModalWindow, backing: .buffered, defer: false)
        
//        setFrame(NSRect(x: screen?.frame.width ?? 22 / 2, y: screen?.frame.height ?? 22 / 2 + 50.0, width: 50.0, height: 50.0), display: true, animate: true)
        
        initViews()
    }
    
    func initViews(){
        contentView?.wantsLayer = true
        contentView?.layer?.cornerRadius = 20.0
        contentView?.layer?.masksToBounds = true
//        level = NSWindow.Level(rawValue: NSWindow.Level.RawValue(CGWindowLevelForKey(.maximumWindow)))
        isOpaque = false
        center()
        contentView?.addSubview(imgClock!)
        imgClock?.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.width.height.equalToSuperview()
        })
        
        delegate = self
        NSApp.activate(ignoringOtherApps: true)
        NotificationCenter.default.addObserver(forName: NSApplication.didResignActiveNotification, object: nil, queue: OperationQueue.main) {[unowned self] (noti) in
            self.level = .floating
            
        }
        screenFrame = screen?.frame ?? .zero
        startTimer()
    }
    
    var timer: DispatchSourceTimer?
    private func startTimer() {
        let queue = DispatchQueue(label: "com.firm.app.timer", attributes: .concurrent)
        timer?.cancel()        // cancel previous timer if any
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(5))
        // or, in Swift 3:
        //
        // timer?.scheduleRepeating(deadline: .now(), interval: .seconds(5), leeway: .seconds(1))
        timer?.setEventHandler { [unowned self] in // `[weak self]` only needed if you reference `self` in this closure and you want to prevent strong reference cycle
            print(Date())
            self.restoreWindow()
        }
        timer?.resume()
    }
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    func windowWillMove(_ notification: Notification) {
        
    }
    
    func windowDidMove(_ notification: Notification) {
        restoreWindow()
    }
    
    private func restoreWindow() {
        DispatchQueue.main.async { [unowned self] in
            print("screen x = \(screenFrame?.origin.x) y = \(screenFrame?.origin.y) w = \(screenFrame?.width) h = \(screenFrame?.height) self.frame.x = \(self.frame.origin.x) self.frame.y = \(self.frame.origin.y)")
            var frame = self.frame
            if frame.origin.x <= 0.0  {
                frame.origin.x = 0.0
                self.setFrame(frame, display: true, animate: true)
            }
            if frame.origin.y <= 0.0 {
                frame.origin.y = 0.0
                self.setFrame(frame, display: true, animate: true)
            }
            if let w = screenFrame?.width {
                print("w = \(w) frame.w = \(frame.origin.x + frame.width)")
                if frame.origin.x + frame.width >= w {
                    frame.origin.x = w - frame.width
                    self.setFrame(frame, display: true, animate: true)
                }
            }
            if let h = screenFrame?.height {
                print("h = \(h) frame.h = \(frame.origin.y + frame.height)")
                if frame.origin.y + frame.height >= h {
                    frame.origin.y = h - frame.height
                    self.setFrame(frame, display: true, animate: true)
                }
            }
            
        }

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSApplication.didResignActiveNotification, object: nil)
        stopTimer()
    }
    
    override func mouseDragged(with event: NSEvent) {
        let ePoint = NSEvent.mouseLocation
        
//        let cPoint = convertPoint(fromScreen: ePoint)
//        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved) { (event) in
//            ePoint = event.locationInWindow
//        }
        setFrame(NSRect(x: ePoint.x, y: ePoint.y, width: 50.0, height: 50.0), display: true, animate: true)
    }
    
    lazy var imgClock: NSImageView? = {
        var image: NSImage = NSImage(named: .appicon) ?? NSImage()
        image = resize(image: image, w: 50, h: 50)
        let img = NSImageView(image: image)
        return img
    }()
    
}

extension NSImage.Name {
    static let clock = NSImage.Name("clock")
    static let appicon = NSImage.Name("AppIcon")
}



func resize(image: NSImage, w: Int, h: Int) -> NSImage {
    let destSize = NSMakeSize(CGFloat(w), CGFloat(h))
    let newImage = NSImage(size: destSize)
    newImage.lockFocus()
    image.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height), from: NSMakeRect(0, 0, image.size.width, image.size.height), operation: NSCompositingOperation.sourceOver, fraction: CGFloat(1))
    newImage.unlockFocus()
    newImage.size = destSize
    return NSImage(data: newImage.tiffRepresentation!)!
}
