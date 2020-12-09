//
//  ModalWindow.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2020/12/7.
//  Copyright © 2020 eport2. All rights reserved.
//

import Cocoa
import ReactiveSwift
import ReactiveCocoa

class ModalWindow: NSWindow, NSWindowDelegate {
    var screenFrame: CGRect? = .zero
    
    init() {
        let rect = NSRect(x: 980.0, y: 0.0, width: 640.0, height: 480.0)
        super.init(contentRect: rect, styleMask: .docModalWindow, backing: .buffered, defer: false)
        
//        setFrame(NSRect(x: screen?.frame.width ?? 22 / 2, y: screen?.frame.height ?? 22 / 2 + 50.0, width: 50.0, height: 50.0), display: true, animate: true)
        
        initViews()
    }
    
    func initViews(){
        contentView?.wantsLayer = true
        contentView?.layer?.cornerRadius = 20.0
        contentView?.layer?.masksToBounds = true
//        level = NSWindow.Level(rawValue: NSWindow.Level.RawValue(CGWindowLevelForKey(.maximumWindow)))
        level = .floating
        isOpaque = false
//        center()
        styleMask = .docModalWindow
        
        screenFrame = screen?.frame ?? .zero
        print("contentView?.subviews = \(contentView?.subviews)")
        contentView?.addSubview(imgClock!)
        imgClock?.isHidden = true
        
        contentView?.addSubview(txtBackView!)
        txtBackView?.isHidden = true
        
        setBox()
        
        delegate = self
        NSApp.activate(ignoringOtherApps: true)
        NotificationCenter.default.addObserver(forName: NSApplication.didResignActiveNotification, object: nil, queue: OperationQueue.main) {[unowned self] (noti) in
            self.level = .floating
            
        }
        
        
        startTimer()
        
//        if let delegate = hDelegate {
//            delegate.changeTitle(title: "ddd")
//        }
        
        let menuItem1 = NSMenuItem(title: "Show Main Window", action: #selector(menuItem1Event(any:)), keyEquivalent: "")
        menuMouse?.addItem(menuItem1)
        
        let menuItem2 = NSMenuItem(title: "Exit App", action: #selector(menuItem2Event(any:)), keyEquivalent: "")
        menuMouse?.addItem(menuItem2)
    }
    
    func setClock(){
        imgClock?.isHidden = false
        txtBackView?.isHidden = true
        let rect = NSRect(x: screenFrame?.width ?? 50.0 - 50.0, y: screenFrame?.height ?? 50.0 / 50.0, width: 50.0, height: 50.0)
        self.setFrame(rect, display: true, animate: true)
        
        imgClock?.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.width.height.equalToSuperview()
        })
    }
    
    func setBox(){
        
        txtBackView?.isHidden = false
        imgClock?.isHidden = true
        let rect = NSRect(x: screenFrame?.width ?? 300.0 - 300.0, y: screenFrame?.height ?? 300.0 / 300.0, width: 300.0, height: 50.0)
        self.setFrame(rect, display: true, animate: true)
        txtBackView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
//        txtBackView?.backgroundColor = .blue
        
        
//        txtBox?.snp.makeConstraints({ (make) in
//            make.edges.equalToSuperview()
//        })
        
//        txtBox?.alignment = .center
//
//        let txtStorge = txtBox?.textStorage
//        let strs = NSAttributedString(string: "dfdfdf")
//        let attstr = NSMutableAttributedString()
//        attstr.append(strs)
//        attstr.addAttributes([NSAttributedString.Key.foregroundColor : NSColor.white], range: NSRange(strs.string) ?? NSRange(location: 0, length: strs.length))
//        txtStorge?.setAttributedString(attstr)
        
        
    }
    
    
    @objc func menuItem1Event(any: Any){
        
    }
    
    @objc func menuItem2Event(any: Any){
        exit(0)
    }
    
    var timer: DispatchSourceTimer?
    private func startTimer() {
        let queue = DispatchQueue(label: "com.firm.app.timer", attributes: .concurrent)
//        timer?.cancel()        // cancel previous timer if any
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(5))
        // or, in Swift 3:
        //
        // timer?.scheduleRepeating(deadline: .now(), interval: .seconds(5), leeway: .seconds(1))
        timer?.setEventHandler { [unowned self] in // `[weak self]` only needed if you reference `self` in this closure and you want to prevent strong reference cycle
            print(Date())
            self.restoreWindow()
            DispatchQueue.main.async {
                self.txtBackView?.setNeedsDisplay(self.txtBackView?.frame ?? .zero)
            }
        }
        timer?.resume()
    }
    private func stopTimer() {
        timer?.cancel()
        timer = nil
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
    
    lazy var txtBox: NSTextView? = {
        let txt = NSTextView()
        return txt
    }()
    
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
        setFrame(NSRect(x: ePoint.x, y: ePoint.y, width: self.frame.width, height: self.frame.height), display: true, animate: true)
        
    }
    
    lazy var txtBackView: ClockView? = {
       let view = ClockView()
        return view
    }()
    
    override func rightMouseUp(with event: NSEvent) {
        let ePoint = NSEvent.mouseLocation
        menuMouse?.popUp(positioning: nil, at: ePoint, in: NSApp.mainWindow?.contentView)
        
    }
    
    lazy var imgClock: NSImageView? = {
        var image: NSImage = NSImage(named: .appicon) ?? NSImage()
        image = resize(image: image, w: 50, h: 50)
        let img = NSImageView(image: image)
        return img
    }()
    
    lazy var menuMouse: NSMenu? = {
       let menu = NSMenu(title: "Menu")
        return menu
    }()
    
    
    
}

extension NSImage.Name {
    static let clock = NSImage.Name("clock")
    static let appicon = NSImage.Name("AppIcon")
}

class ClockView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        let date = Date()
        let ss: NSString = date.string(withFormat: "HH:mm:ss") as NSString
        let textRect = ss.boundingRect(with: frame.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.foregroundColor: NSColor.white, NSAttributedString.Key.font: NSFont.systemFont(ofSize: 32.0)])
        ss.draw(in: NSOffsetRect(self.frame, self.frame.width / 2 - textRect.width / 2, -(self.frame.height / 2 - textRect.height / 2)), withAttributes: [NSAttributedString.Key.foregroundColor: NSColor.white, NSAttributedString.Key.font: NSFont.systemFont(ofSize: 32.0)])
    }
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
