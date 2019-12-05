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
    
    lazy var viewLine: NSView? = {
        let view = NSView();
        view.backgroundColor = NSColor.lightGray;
        return view
    }();

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "代码生成";
        

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
        view.addSubview(viewLine!);
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
                let vc = self?.storyboard?.instantiateController(withIdentifier: "createOCFile") as! NSViewController
                self?.presentAsSheet(vc);
            }
        })
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

    }
    
    override func viewWillLayout() {
        super.viewWillLayout();
        layout();
    }


}

