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
import MediaPlayer
import AVFoundation
import AVKit
import Foundation

class ModalWindow: NSWindow, NSWindowDelegate {
    var screenFrame: CGRect? = .zero
    var windowX, windowY: CGFloat?
    var mainVC: NSViewController?
    
    init() {
        let rect = NSRect(x: 0, y: 0.0, width: 640.0, height: 480.0)
        super.init(contentRect: rect, styleMask: .docModalWindow, backing: .buffered, defer: false)
        
//        setFrame(NSRect(x: screen?.frame.width ?? 22 / 2, y: screen?.frame.height ?? 22 / 2 + 50.0, width: 50.0, height: 50.0), display: true, animate: true)
        
        initViews()
    }
    
    init(_ vc: NSViewController) {
        let rect = NSRect(x: 0, y: 0.0, width: 640.0, height: 480.0)
        super.init(contentRect: rect, styleMask: .docModalWindow, backing: .buffered, defer: false)
        mainVC = vc
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
        
        windowX = AppInfo.mainWindowRect.origin.x
        windowY = AppInfo.mainWindowRect.origin.y
        contentView?.addSubview(imgClock!)
        imgClock?.isHidden = true
        
        contentView?.addSubview(txtBackView!)
        txtBackView?.isHidden = true
        
        setBox()
        
        delegate = self
        NSApp.activate(ignoringOtherApps: true)
        NotificationCenter.default.addObserver(forName: NSApplication.didResignActiveNotification, object: nil, queue: OperationQueue.main) {[weak self] (noti) in
            self?.level = .floating
            
        }
        
        
        startTimer()
        
//        if let delegate = hDelegate {
//            delegate.changeTitle(title: "ddd")
//        }
        
        let menuItem1 = NSMenuItem(title: "Show Main Window", action: #selector(menuItem1Event(any:)), keyEquivalent: "")
        menuMouse?.addItem(menuItem1)
        
        let menuItem2 = NSMenuItem(title: "Exit App", action: #selector(menuItem2Event(any:)), keyEquivalent: "")
        menuMouse?.addItem(menuItem2)
        
        let menuItem3 = NSMenuItem(title: "Show Full Date", action: #selector(menuItem3Event(any:)), keyEquivalent: "")
        // 设置菜单项为复选框类型
        menuItem3.state = NSControl.StateValue.off // 默认状态为未选中
//        menuItem.onStateImage = NSImage(named: NSImage.c) // 选中时的图像
//       menuItem.offStateImage = nil  // 未选中时没有图像，也可以设置一个图像
        menuMouse?.addItem(menuItem3)
        
        let menuItem4 = NSMenuItem(title: "Player", action: #selector(menuItem4Event(any:)), keyEquivalent: "")
        menuMouse?.addItem(menuItem4)
        
        let menuItem5 = NSMenuItem(title: "En/Des Crypoto", action: #selector(menuItem5Action(sender:)), keyEquivalent: "")
        
        menuMouse?.addItem(menuItem5)
        
        let menuItem6 = NSMenuItem(title: "SM4", action: #selector(menuItem6Action(sender:)), keyEquivalent: "")
        menuMouse?.addItem(menuItem6)
        
        let menuItem7 = NSMenuItem(title: "Quit", action: #selector(menuItem7Action(sender:)), keyEquivalent: "")
//        menuMouse?.addItem(menuItem7)
        
        let menuItem8 = NSMenuItem(title: "load plist", action: #selector(menuItem8Action(sender:)), keyEquivalent: "")
        menuMouse?.addItem(menuItem8)
        
        let menuItem9 = NSMenuItem(title: "Show Disk Capacity", action: #selector(menuItem9Action(sender:)), keyEquivalent: "")
        menuMouse?.addItem(menuItem9)
        
        let menuItem10 = NSMenuItem(title: "Show B Web", action: #selector(menuItem10Action(sender:)), keyEquivalent: "")
        menuMouse?.addItem(menuItem10)
    }
    
    
    func setClock(){
        imgClock?.isHidden = false
        txtBackView?.isHidden = true
        let rect = NSRect(x: AppInfo.mainWindowRect.origin.x, y: AppInfo.mainWindowRect.origin.y, width: 50.0, height: 50.0)
        self.setFrame(rect, display: true, animate: true)
        
        imgClock?.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.width.height.equalToSuperview()
        })
    }
    
    func setBox(){
        
        txtBackView?.isHidden = false
        imgClock?.isHidden = true
//        let rect = NSRect(x: screenFrame?.width ?? 300.0 - 300.0, y: screenFrame?.height ?? 300.0 / 300.0, width: 150.0, height: 50.0)
        var sX = 0
        var sY = 0
        
        let rect = NSRect(x: AppInfo.mainWindowRect.origin.x, y: AppInfo.mainWindowRect.origin.y, width: 150.0, height: 50.0)
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
    
    func windowWillClose(_ notification: Notification) {
        
    }
    
    func presentOpenPanel() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.title = "请选择文件"
        openPanel.allowedFileTypes = ["plist"]
        
        openPanel.begin { [unowned self] (result) in
            if result == .OK, let selectedURL = openPanel.url {
                print("选中的文件路径: \(selectedURL)")
                // 处理文件内容
                do {
                    let data = try Data(contentsOf: selectedURL)
                    print("文件内容大小: \(data.count) bytes")
                    let dic = try Utils.dataToDictionary(from: data)
                    print("dic = \(dic)")
                    showPlist(dic ?? [:])
                } catch {
                    print("读取文件失败: \(error)")
                }
            }
        }
    }
    
    private func showPlist(_ dic: Dictionary<String, Any>){
        let parsePlist = ParsePlist()
        parsePlist.view.snp.makeConstraints { make in
            make.width.equalTo(500)
            make.height.equalTo(800)
        }
        parsePlist.setData(dic)
        mainVC?.presentAsModalWindow(parsePlist)
        
    }
    
    @objc func menuItem9Action(sender: NSMenuItem) {
        Alert.show(title: Utils.getDiskFreeCapacityFormatted(), window: self) {
            
        }
    }
    
    @objc func menuItem8Action(sender: NSMenuItem) {
        presentOpenPanel()
    }
    
    @objc func menuItem7Action(sender: NSMenuItem) {
        exit(0)
    }
    
    @objc func menuItem6Action(sender: NSMenuItem) {
//        DispatchQueue.main.async {
//            for window in NSApplication.shared.windows {
//                if !window.isKind(of: ModalWindow.self) {
//    //                window.makeKeyAndOrderFront(nil)
//                    window.orderFront(nil)
//                    
//                    break
//                }
//            }
//    //        if let window = NSApplication.shared.windows.first {
//    //            NSApp.runModal(for: window)
//                
//    //            shared?.mainSession = NSApp.beginModalSession(for: window)
//    //            delegate.vc?.view.window?.setIsVisible(true)
//    //        }
//            self.orderOut(nil)
//
//        }
        
        let vc = mainVC?.storyboard?.instantiateController(withIdentifier: "aesCryptVC") as! AESCryptVC
        vc.view.snp.makeConstraints { make in
            make.height.equalTo(500)
        }
        mainVC?.presentAsModalWindow(vc)
//        mainVC?.presentAsSheet(vc)
    }
    
    @objc func menuItem5Action(sender: NSMenuItem) {
        let vc = mainVC?.storyboard?.instantiateController(withIdentifier: "CryptoVC") as! CryptoVC
//        vc.view.snp.makeConstraints { (make) in
//            make.height.equalTo(500.0)
//        }
//        mainVC?.presentAsSheet(vc)
        mainVC?.presentAsModalWindow(vc)
    }
    
    @objc func menuItem4Event(any: Any){
        openSelectDialog()
    }
    
    @objc func menuItem3Event(any: Any){
        let menuItem = any as? NSMenuItem
        if menuItem?.state == NSControl.StateValue.off {
            menuItem?.state = NSControl.StateValue.on
            txtBackView?.isFull = true
            let rect = NSRect(x: windowX ?? 0, y: windowY ?? 0, width: 450.0, height: 50.0)
            self.setFrame(rect, display: true, animate: true)
        }else{
            menuItem?.state = NSControl.StateValue.off
            txtBackView?.isFull = false
            let rect = NSRect(x: windowX ?? 0, y: windowY ?? 0, width: 150.0, height: 50.0)
            self.setFrame(rect, display: true, animate: true)
        }
    }
    
    @objc func menuItem1Event(any: Any){
//        self.hidesOnDeactivate = true
//        self.setIsVisible(false)
//        self.orderOut(nil)
//        if let session = shared?.mainSession {
//            NSApplication.shared.endModalSession((shared?.window1Session)!)
//        }
//        if let window = shared?.window1 {
//            window.close()
//            NSApp.removeWindowsItem(window)
//        }
        
        print("=============== windows = \(NSApplication.shared.windows)")
        DispatchQueue.main.async {
            for window in NSApplication.shared.windows {
                if !window.isKind(of: ModalWindow.self) {
    //                window.makeKeyAndOrderFront(nil)
                    var rect = window.frame
                    rect.origin.x = self.windowX ?? 0
                    rect.origin.y = self.windowY ?? 0
                    window.setFrame(rect, display: true)
                    window.orderFront(nil)
                    break
                }
            }
    //        if let window = NSApplication.shared.windows.first {
    //            NSApp.runModal(for: window)
                
    //            shared?.mainSession = NSApp.beginModalSession(for: window)
    //            delegate.vc?.view.window?.setIsVisible(true)
    //        }
            self.orderOut(nil)

        }
    }
    
    @objc func menuItem2Event(any: Any){
        exit(0)
    }
    
    @objc func menuItem10Action(sender: NSMenuItem){
        DispatchQueue.main.async {
            let bWebController = BWebController()
            let rect = NSRect(x: 0, y: 0, width: 640, height: 480)
            bWebController.view.frame = rect
//            let bWebSB = NSStoryboard(name: "Main", bundle: Bundle(for: BWebController.self))
//            let vc = bWebSB.instantiateController(withIdentifier: "BWebController") as? BWebController
            self.mainVC?.presentAsModalWindow(bWebController)

        }
    }
    
    private func playMedia(url: URL){
//        let mediaURL = NSURL(fileURLWithPath: "")
        do {
            
            let player = AVPlayer(url: url)
            
            
            try player.play()
        } catch let e {
            NSLog("e = ", e.localizedDescription)
        }

    }
    
    private func openSelectDialog(){
        let openPanel = NSOpenPanel()
                
                // 设置可接受的文件类型（例如，视频文件）
                openPanel.allowedFileTypes = ["mpeg", "mp4", "com.apple.quicktime.movie", "mkv", "flv"]
        if #available(macOS 11.0, *) {
            openPanel.allowedContentTypes = [UTType.movie]
        } else {
            // Fallback on earlier versions
        }
                
                // 显示面板并获取选择的文件
                if openPanel.runModal() == .OK {
//                    let selectedFiles = openPanel.urls
                    if let selectedFiles = openPanel.url {
//                        for fileURL in selectedFiles {
                            // 处理所选文件（例如，播放视频）
//                            processVideoFile(at: fileURL)
//                        }
                        print("selectedFiles = ", selectedFiles)
                        playMedia(url: selectedFiles)
                    }
                }
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
        timer?.setEventHandler { [weak self] in // `[weak self]` only needed if you reference `self` in this closure and you want to prevent strong reference cycle
//            print(Date())
            self?.restoreWindow()
            DispatchQueue.main.async {
                self?.txtBackView?.setNeedsDisplay(self?.txtBackView?.frame ?? .zero)
            }
        }
        timer?.resume()
    }
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func restoreWindow() {
        guard let sf = screenFrame else {
            return
        }
        DispatchQueue.main.async { [weak self] in
//            print("screen x = \(self?.screenFrame?.origin.x) y = \(self?.screenFrame?.origin.y) w = \(self?.screenFrame?.width) h = \(self?.screenFrame?.height) self.frame.x = \(self?.frame.origin.x) self.frame.y = \(self?.frame.origin.y)")
            var frame = self?.frame ?? .zero
            if frame.origin.x <= 0.0  {
                frame.origin.x = 0.0
                self?.setFrame(frame, display: true, animate: true)
            }
            if frame.origin.y <= 0.0 {
                frame.origin.y = 0.0
                self?.setFrame(frame, display: true, animate: true)
            }
            if let w = self?.screenFrame?.width {
//                print("w = \(w) frame.w = \(frame.origin.x + frame.width)")
                if frame.origin.x + frame.width >= w {
                    frame.origin.x = w - frame.width
                    self?.setFrame(frame, display: true, animate: true)
                }
            }
            if let h = self?.screenFrame?.height {
//                print("h = \(h) frame.h = \(frame.origin.y + frame.height)")
                if frame.origin.y + frame.height >= h {
                    frame.origin.y = h - frame.height
                    self?.setFrame(frame, display: true, animate: true)
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
        windowX = ePoint.x
        windowY = ePoint.y
        
    }
    
    lazy var txtBackView: ClockView? = {
       let view = ClockView()
        return view
    }()
    
    override func rightMouseUp(with event: NSEvent) {
//        let ePoint = NSEvent.mouseLocation
//        menuMouse?.popUp(positioning: nil, at: ePoint, in: NSApp.windows.first?.contentView)//NSApp.mainWindow?.contentView
        NSMenu.popUpContextMenu(menuMouse!, with: event, for: self.contentView!)
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
    public var isFull = false
    
    override func draw(_ dirtyRect: NSRect) {
        let date = Date()
        var ss: NSString = date.string(withFormat: "HH:mm:ss") as NSString
        if isFull {
            ss = date.string(withFormat: "yyyy-MM-dd HH:mm:ss") as NSString
            let weekdayName = getWeekdayName(from: date)
            ss = ss.appendingFormat("%@", weekdayName)
        }
        let textRect = ss.boundingRect(with: frame.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.foregroundColor: NSColor.white, NSAttributedString.Key.font: NSFont.systemFont(ofSize: 32.0)])
        ss.draw(in: NSOffsetRect(self.frame, self.frame.width / 2 - textRect.width / 2, -(self.frame.height / 2 - textRect.height / 2)), withAttributes: [NSAttributedString.Key.foregroundColor: NSColor.white, NSAttributedString.Key.font: NSFont.systemFont(ofSize: 32.0)])
    }
    
    func getWeekdayName(from date: Date) -> NSString {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        
        let weekdays = [
            "星期日", "星期一", "星期二", "星期三",
            "星期四", "星期五", "星期六"
        ]
        
        return weekdays[weekday - 1] as NSString // weekday是从1（星期日）开始的
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

