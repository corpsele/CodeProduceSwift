//
//  ViewController.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2019/12/2.
//  Copyright © 2019 eport2. All rights reserved.
//

import Cocoa
import ReactiveSwift
import ReactiveCocoa

class ViewController: NSViewController {
//    func changeTitle(title: String) {
//        print("title = \(title)")
//    }
    
    
    private var vm: ViewModel!
//    @IBOutlet weak var mainWindow: NSWindow!
    
    lazy var btnWindow: NSButton? = {
       let btn = NSButton()
        btn.title = "Show Modal"
        btn.font = NSFont.boldSystemFont(ofSize: 15.0)
        return btn
    }()
    
    // MARK: 文件按钮
    lazy var btnFile: NSButton? = {
        let btn = NSButton();
        btn.title = "文件";
        btn.font = NSFont.boldSystemFont(ofSize: 20.0);
        return btn;
    }();
    
    // MARK: 代码按钮
    lazy var btnCode: NSButton? = {
        let btn = NSButton();
        btn.title = "代码";
        btn.font = NSFont.boldSystemFont(ofSize: 20.0);
        btn.shadowRadius = 5.0;
        btn.shadowColor = NSColor(hex: 0x4D79BC);
        return btn;
    }();
    
    lazy var viewLine: NSView? = {
        let view = NSView();
        view.backgroundColor = NSColor.lightGray;
        return view
    }();
    
    lazy var btnCrypt: NSButton? = {
       let btn = NSButton()
        btn.title = "Crypt"
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "代码生成";
        
        vm = ViewModel()

        // Do any additional setup after loading the view.
        
        createViews();
        
        doThings();
        
        NSApplication.shared.windows.first?.title = AppInfo.appDisplayName
        
        print(AppInfo.appDisplayName)
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    // MARK: 创建文件入口
    private func createViews()
    {
        view.addSubview(btnFile!);
        view.addSubview(btnCode!);
        view.addSubview(viewLine!);
        view.addSubview(btnCrypt!);
        view.addSubview(btnWindow!)
    }
    
    // MARK: 处理逻辑
    private func doThings(){

//        if let action = vm.btnFileAction {
            btnFile?.reactive.pressed = CocoaAction<NSButton>(vm.btnFileAction){
                sender in
                print("tag = \(sender.tag)");
            }
//        }
//        if let action = vm.btnCodeAction {
            btnCode?.reactive.pressed = CocoaAction<NSButton>(vm.btnCodeAction){ sender in
                
            }
//        }
//        if let action = vm.btnCryptAction {
            btnCrypt?.reactive.pressed = CocoaAction<NSButton>(vm.btnCryptAction){ sender in
                
            }
//        }
        
        btnWindow?.reactive.pressed = CocoaAction<NSButton>(vm.btnWindowAction){ sender in
            
        }
        
        vm.btnWindowAction.values.observeValues({ [unowned self] success in
            if success {
                print("btnWindowAction")
//                modalWindow?.hDelegate = self
                self.view.window?.hidesOnDeactivate = true
                self.view.window?.setIsVisible(false)
                NSApp.runModal(for: modalWindow!)
            }
        })
        
        //观察登录是否成功
        vm.btnFileAction.values.observeValues({ [unowned self] success in
            if success {
                print("btnFileAction : \(success)" )
                let vc = self.storyboard?.instantiateController(withIdentifier: "createOCFile") as! NSViewController
                self.presentAsSheet(vc);
                
            }
        })
        
        vm.btnCodeAction.values.observeValues {[unowned self] (flag) in
            let vc = self.storyboard?.instantiateController(withIdentifier: "createOCCode") as! NSViewController
            self.presentAsSheet(vc);
        }
        
        vm.btnCryptAction.values.observeValues {[unowned self] (flag) in
            let vc = self.storyboard?.instantiateController(withIdentifier: "aesCryptVC") as! NSViewController
            vc.view.snp.makeConstraints { (make) in
                make.height.equalTo(500)
            }
            self.presentAsSheet(vc)
//            self?.presentAsModalWindow(vc)
        }
    }
    
    // MARK: layout
    private func layout(){
        if let view = viewLine {
            view.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview();
                make.centerY.equalToSuperview();
                make.width.equalTo(3.0);
                make.height.equalTo(view.bounds.size.height);
            };
        }
        if let btn = btnFile {
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo(view).offset(60.0);
                make.right.equalTo(viewLine!).offset(-10.0);
                make.top.equalTo(view).offset(60.0);
//                make.width.equalTo(150.0);
                make.bottom.equalTo(view).offset(-60.0);
            });
        }
        if let btn = btnCode {
            btn.snp.makeConstraints { (make) in
                make.right.equalTo(view).offset(-60.0);
                make.left.equalTo(viewLine!).offset(10.0);
                make.top.equalTo(view).offset(60.0);
//                make.width.equalTo(150.0);
                make.bottom.equalTo(view).offset(-60.0);
            };
        }
        
        if let btn = btnCrypt {
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.top.equalToSuperview()
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
        }
        
        if let btn = btnWindow {
            btn.snp.makeConstraints { (make) in
                make.right.top.equalToSuperview()
                make.width.height.equalTo(50.0)
            }
        }

    }
    
    lazy var modalWindow: ModalWindow? = {
       let window = ModalWindow()
        return window
    }()
    
    override func viewWillLayout() {
        super.viewWillLayout();
        layout();
    }


}

