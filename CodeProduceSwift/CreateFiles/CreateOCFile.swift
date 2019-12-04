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
import RxSwift
//import ReactiveKit

class CreateOCFile: NSViewController {
    @IBOutlet weak var tTextField: NSTextField!
    
    var strFileName: String = ""
    
    @IBAction func btnCreateMVVMAction(_ sender: Any) {
//        writeFile();
        
        let tfName = view.viewWithTag(191912) as! NSTextField;
//        tfName.reactive.continuousStringValues.observeValues { (str) in
//            print(str);
//        }
//        vm.textChangedSignal = tfName.reactive.continuousStringValues.map{ _ in tfName }
//
//
//
//        vm.tfText <~ tfName.reactive.continuousStringValues
//
//        vm.textSignal = tfName.reactive.continuousStringValues.map{tf in
//            print(tf)
//            }.producer
        
        vm.textChangedObserver.send(value: tfName)
        
        vm.tfText.value = tfName.stringValue
        
        vm.createFileObserver.send(value: ())
    }
    
    let vm = CreateOCFileVM();
    lazy var btnClose: NSButton? = {
        let btn = NSButton();
        btn.title = "关闭";
        return btn;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        initViews();
        
        btnClose?.reactive.pressed = CocoaAction<NSButton>(vm.btnCloseAction) { [weak self] sender in
            self?.dismiss(self);
        }
        
        doThings();
    }
    
    private func doThings(){
        let tfName = view.viewWithTag(191912) as! NSTextField;
        tfName.reactive.continuousStringValues.observeValues {[weak self] (str) in
            self?.strFileName = str
            print(str);
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
        
    }
}
