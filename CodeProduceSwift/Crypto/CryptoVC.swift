//
//  CryptoVC.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2021/2/2.
//  Copyright © 2021 eport2. All rights reserved.
//

import Cocoa

class CryptoVC: NSViewController {
    let vm = CryptoVM()
    
    @IBOutlet weak var inputText: NSScrollView!
    @IBOutlet weak var outputText: NSScrollView!
    @IBOutlet weak var btnEn: NSButton!
    @IBOutlet weak var btnDe: NSButton!
    @IBOutlet weak var btnPopup: NSPopUpButton!
    
//    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    lazy var btnClose: NSButton = {
        let btn = NSButton()
        btn.title = "Close"
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.addSubview(btnClose)
        btnClose.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-10.0)
            make.width.height.equalTo(50.0)
        }
        
        btnClose.reactive.pressed = CocoaAction<NSButton>(vm.closeAction) {[unowned self] (sender) in
            self.dismiss(self)
        }
        
        btnEn.reactive.pressed = CocoaAction<NSButton>(vm.enAction) {[unowned self] sender in
            
            if let tv = self.inputText.documentView as? NSTextView {
                self.vm.inputText = tv.string
            }
            if let tv = self.outputText.documentView as? NSTextView {
                tv.replaceCharacters(in: NSRange(location: 0, length: tv.string.count), with: "")
                tv.insertText(self.vm.enMethod(), replacementRange: .init())
                
            }
        }
        
        btnPopup.reactive.selectedIndexes.observeValues {[unowned self] (index) in
            self.vm.selectedIndex.value = index
        }
        
        btnDe.reactive.states.observeValues { (state) in
            
        }
        
        
    }
    
}
