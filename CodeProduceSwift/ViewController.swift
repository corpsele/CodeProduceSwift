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
    
    let vm = ViewModel();
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createViews();
        
        doThings();
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
    }
    
    // MARK: 处理逻辑
    private func doThings(){

        btnFile?.reactive.pressed = CocoaAction<NSButton>(vm.btnFileAction){
            sender in
            print("tag = \(sender.tag)");
        }
        //观察登录是否成功
        vm.btnFileAction.values.observeValues({ [weak self] success in
            if success {
                print("btnFileAction : \(success)" )
                let vc = CreateOCFile();
                
            }
        })
    }
    
    // MARK: layout
    private func layout(){
        if let btn = btnFile {
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo(view).offset(60.0);
                make.top.equalTo(view).offset(60.0);
                make.width.equalTo(150.0);
                make.bottom.equalTo(view).offset(-60.0);
            });
        }
        if let btn = btnCode {
            btn.snp.makeConstraints { (make) in
                make.right.equalTo(view).offset(-60.0);
                make.top.equalTo(view).offset(60.0);
                make.width.equalTo(150.0);
                make.bottom.equalTo(view).offset(-60.0);
            };
        }
    }
    
    override func viewWillLayout() {
        super.viewWillLayout();
        layout();
    }


}

