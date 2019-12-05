//
//  CreateOCCodeVM.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2019/12/5.
//  Copyright © 2019 eport2. All rights reserved.
//

import Cocoa

import ReactiveCocoa
import ReactiveSwift
import RxSwift

enum SelectType: Int {
    case SelectType_Default = 0
    case SelectType_Corner
    case SelectType_Hex
}

enum SelectArgType: Int {
    case SelectArgType_Default = 0
    case SelectArgType_Five = 5
    case SelectArgType_Ten = 10
    case SelectArgType_Fifth = 15
}

class CreateOCCodeVM: NSObject {
    
    var btnClose = MutableProperty(NSButton())
    var btnDo = MutableProperty(NSButton())
    var btnPopThing = MutableProperty(NSPopUpButton())
    var btnPopArg = MutableProperty(NSPopUpButton())
    var selectType = MutableProperty<SelectType>(SelectType.SelectType_Default)
    var selectArgType = MutableProperty<SelectArgType>(SelectArgType.SelectArgType_Default)
    var layoutSignal:SignalProducer<(() -> Void), Never>!
    var window = MutableProperty(NSWindow())
    
    private var btnDoDo: NSPopUpButton?
    
    var btnCloseAction = Action<Void,Void,Never>{ (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
//            observer.send(value: ());
            observer.sendCompleted();
        }
        
    }
    
    var btnDoAction = Action<Void,Void,Never>{ (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
//            observer.send(value: ());
            observer.sendCompleted();
        }
        
    }
    
    var layoutAction = Action<Void,Void,Never>{ (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
//            observer.send(value: ());
            observer.sendCompleted();
        }
        
    }
    
    override init() {
        super.init();
        
        doThings()
    }
    
    func doThings(){
        btnClose.signal.observeValues { (btn) in
            print("btn tag = \(btn.tag)")
        }
        
        btnDoAction.events.observeValues {[weak self] (event) in
            if self?.selectType.value == SelectType.SelectType_Default {
                Alert.show(title: "请选择", window: (NSApplication.shared.windows.last)!, block: {
                    
                });
            }
        }
        
        
        selectType.signal.observeValues {[weak self] (type) in
            if type != .SelectType_Default {
                self?.btnDoDo?.isHidden = false
            }else{
                self?.btnDoDo?.isHidden = true
            }
            
        }
        
        btnPopArg.signal.observeValues {[weak self] (btn) in
            print("btn tag = \(btn.tag)")
            self?.btnDoDo = btn
        }
        
        
    }

}
