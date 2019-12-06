//
//  CreateOCCode.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2019/12/5.
//  Copyright © 2019 eport2. All rights reserved.
//

import Cocoa
import ReactiveSwift
import ReactiveCocoa
import RxSwift

class CreateOCCode: NSViewController {
    
    @IBOutlet weak var tvMain: NSTextView!
    @IBOutlet weak var btnPopThing: NSPopUpButton!
    @IBOutlet weak var btnPopArg: NSPopUpButton!
    @IBOutlet weak var btnDo: NSButton!
    @IBOutlet weak var btnPopThingLayout: NSLayoutConstraint!
    
    let vm = CreateOCCodeVM();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let btnClose = view.viewWithTag(12333) as! NSButton;
        vm.btnClose.value = btnClose;
        btnClose.reactive.pressed = CocoaAction<NSButton>(vm.btnCloseAction) { [weak self] sender in
            self?.dismiss(self)
        }
        
        vm.btnDo.value = btnDo
        btnDo.reactive.pressed = CocoaAction<NSButton>(vm.btnDoAction) { [weak self] sender in
            
        }
        
        btnPopThing.reactive.selectedIndexes.observeValues {[weak self] (index) in
            self?.vm.selectType.value = SelectType(rawValue: index)!
            self?.view.needsLayout = true
        }
        
        btnPopArg.reactive.selectedIndexes.observeValues {[weak self] (index) in
            self?.vm.selectArgType.value = SelectArgType(rawValue: index)!
        }
        
        vm.btnPopThing.value = btnPopThing
        
        vm.btnPopArg.value = btnPopArg
        
        vm.tvMain.value = tvMain
    
        
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
        
        if let pop = btnPopThing {
            let str = pop.selectedItem?.title.nsString;
            let size = pop.frame.size
            let rect = str?.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 15.0)] , context: nil)
            btnPopThingLayout.constant = (rect?.size.width)! + 30
        }
    }
    
    
    
    
    
}
