//
//  ViewController.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2019/12/2.
//  Copyright © 2019 eport2. All rights reserved.
//

import Cocoa
import ReactiveCocoa
import ReactiveSwift
import RxSwift

class ViewController: NSViewController {
//    func changeTitle(title: String) {
//        print("title = \(title)")
//    }

    private var vm: ViewModel!
//    @IBOutlet weak var mainWindow: NSWindow!
//    var modalWindow: ModalWindow?

    lazy var btnWindow: NSButton? = {
        let btn = NSButton()
        btn.title = "Show Modal"
        btn.font = NSFont.boldSystemFont(ofSize: 15.0)
        return btn
    }()

    // MARK: 文件按钮

    lazy var btnFile: NSButton? = {
        let btn = NSButton()
        btn.title = "文件"
        btn.font = NSFont.boldSystemFont(ofSize: 20.0)
        return btn
    }()

    // MARK: 代码按钮

    lazy var btnCode: NSButton? = {
        let btn = NSButton()
        btn.title = "代码"
        btn.font = NSFont.boldSystemFont(ofSize: 20.0)
        btn.shadowRadius = 5.0
        btn.shadowColor = NSColor(hex: 0x4D79BC)
        return btn
    }()

    lazy var viewLine: NSView? = {
        let view = NSView()
        view.backgroundColor = NSColor.lightGray
        return view
    }()

    lazy var btnCrypt: NSButton? = {
        let btn = NSButton()
        btn.title = "Crypt"
        return btn
    }()

    lazy var btnTaskMenu: NSButton? = {
        let btn = NSButton()
        btn.title = "Menu"
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "代码生成";

        vm = ViewModel()

        // Do any additional setup after loading the view.

        createViews()

        doThings()

        NSApplication.shared.windows.first?.title = AppInfo.appDisplayName

        print(AppInfo.appDisplayName)

//        modalWindow = ModalWindow()

        if shared?.window1 == nil {
            shared?.window1 = modalWindow
        }
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    // MARK: 创建文件入口

    private func createViews() {
        view.addSubview(btnFile!)
        view.addSubview(btnCode!)
        view.addSubview(viewLine!)
        view.addSubview(btnCrypt!)
        view.addSubview(btnWindow!)
        view.addSubview(btnTaskMenu!)
    }

    // MARK: 处理逻辑

    private func doThings() {
//        if let action = vm.btnFileAction {
        btnFile?.reactive.pressed = CocoaAction<NSButton>(vm.btnFileAction) {
            sender in
            print("tag = \(sender.tag)")
        }
//        }
//        if let action = vm.btnCodeAction {
        btnCode?.reactive.pressed = CocoaAction<NSButton>(vm.btnCodeAction) { _ in
        }
//        }
//        if let action = vm.btnCryptAction {
        btnCrypt?.reactive.pressed = CocoaAction<NSButton>(vm.btnCryptAction) { _ in
        }
//        }

        btnWindow?.reactive.pressed = CocoaAction<NSButton>(vm.btnWindowAction) { _ in
        }
        
        btnTaskMenu?.reactive.pressed = CocoaAction<NSButton>(vm.btnTaskMenuAction) { _ in
            
        }

        vm.btnWindowAction.values.observeValues { [weak self] success in
            if success {
                print("btnWindowAction")
//                modalWindow?.hDelegate = self
//                self.view.window?.hidesOnDeactivate = true
//                self.view.window?.setIsVisible(false)
//                self.view.window?.close()
//                if let delegate = NSApplication.shared.delegate as? AppDelegate {
//                    delegate.window?.orderOut(nil)
//                }
//                if let window = shared?.window1 {
//                if self?.modalWindow == nil {
//                    self?.modalWindow = ModalWindow()
//                }
//                let modalW = ModalWindow()
                DispatchQueue.main.async {
//                    self?.modalWindow?.makeKeyAndOrderFront(nil)
                    self?.modalWindow?.orderFront(nil)

                    for window in NSApplication.shared.windows {
                        if !window.isKind(of: ModalWindow.self) {
                            window.orderOut(nil)
                        }
                    }
                }

//                    NSApp.runModal(for: window)
//                }
//                NSApplication.shared.endModalSession((shared?.mainSession)!)
//                shared?.window1Session = NSApp.beginModalSession(for: modalWindow!)
            }
        }

        // 观察登录是否成功
        vm.btnFileAction.values.observeValues { [unowned self] success in
            if success {
                print("btnFileAction : \(success)")
                let vc = self.storyboard?.instantiateController(withIdentifier: "createOCFile") as! NSViewController
                self.presentAsSheet(vc)
            }
        }

        vm.btnCodeAction.values.observeValues { [unowned self] _ in
            let vc = self.storyboard?.instantiateController(withIdentifier: "createOCCode") as! NSViewController
            self.presentAsSheet(vc)
        }

        vm.btnCryptAction.values.observeValues { [unowned self] _ in
            let vc = self.storyboard?.instantiateController(withIdentifier: "aesCryptVC") as! NSViewController
            vc.view.snp.makeConstraints { make in
                make.height.equalTo(500)
            }
            self.presentAsSheet(vc)
//            self?.presentAsModalWindow(vc)
        }
        
        let menuItem1 = NSMenuItem(title: "Show Task View", action: #selector(menuItem1Action(sender:)), keyEquivalent: "")

        taskMenu?.addItem(menuItem1)
        
        vm.btnTaskMenuAction.values.observeValues { [unowned self] _ in
            if let event = NSApp.currentEvent {
                NSMenu.popUpContextMenu(self.taskMenu!, with: event, for: self.btnTaskMenu!)
            }
            
        }
    }
    
    @objc func menuItem1Action(sender: NSMenuItem){
            let vc = TaskVC.init(nibName: "TaskVC", bundle: Bundle.main)
            self.presentAsSheet(vc)
    }

    // MARK: layout

    private func layout() {
        if let view = viewLine {
            view.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalTo(3.0)
                make.height.equalTo(view.bounds.size.height)
            }
        }
        if let btn = btnFile {
            btn.snp.makeConstraints { make in
                make.left.equalTo(view).offset(60.0)
                make.right.equalTo(viewLine!).offset(-10.0)
                make.top.equalTo(view).offset(60.0)
//                make.width.equalTo(150.0);
                make.bottom.equalTo(view).offset(-60.0)
            }
        }
        if let btn = btnCode {
            btn.snp.makeConstraints { make in
                make.right.equalTo(view).offset(-60.0)
                make.left.equalTo(viewLine!).offset(10.0)
                make.top.equalTo(view).offset(60.0)
//                make.width.equalTo(150.0);
                make.bottom.equalTo(view).offset(-60.0)
            }
        }

        if let btn = btnCrypt {
            btn.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.top.equalToSuperview()
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
        }

        if let btn = btnWindow {
            btn.snp.makeConstraints { make in
                make.right.top.equalToSuperview()
                make.width.height.equalTo(50.0)
            }
        }
        
        if let btn = btnTaskMenu {
            btn.snp.makeConstraints { (make) in
                make.left.equalTo((btnCrypt?.snp.right)!).offset(3.0)
                make.top.equalToSuperview()
                make.width.height.equalTo(50.0)
            }
        }
    }
    
    lazy var taskMenu: NSMenu? = {
        let menu = NSMenu()
        menu.title = "Task Menu"
        return menu
    }()

    lazy var modalWindow: ModalWindow? = {
        let window = ModalWindow()
        return window
    }()

    override func viewWillLayout() {
        super.viewWillLayout()
        layout()
    }
}
