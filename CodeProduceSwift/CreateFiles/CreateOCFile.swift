//
//  CreateOCFile.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2019/12/2.
//  Copyright © 2019 eport2. All rights reserved.
//

import Cocoa

import SwifterSwift
import ReactiveSwift
import ReactiveCocoa

class CreateOCFile: NSViewController {
    let vm = CreateOCFileVM();
    lazy var btnClose: NSButton? = {
        let btn = NSButton();
        btn.title = "关闭";
        return btn;
    }();
    
    lazy var tTitle: NSText? = {
        let text = NSText();
        text.string = "创建OC MVVM 文件";
        return text;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        initViews();
        
        btnClose?.reactive.pressed = CocoaAction<NSButton>(vm.btnCloseAction) { [weak self] sender in
            self?.dismiss(self);
        }
    }
    
    private func initViews()
    {
        view.addSubview(btnClose!);
        btnClose?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(view);
            make.height.width.equalTo(50.0);
            make.right.equalTo(view).offset(-10.0);
//            make.width.equalTo(100.0);
        })
        
        view.addSubview(tTitle!);
        tTitle?.snp.makeConstraints({ (make) in
            make.top.left.equalToSuperview();
            make.height.equalTo(50.0);
        })
    }
}
