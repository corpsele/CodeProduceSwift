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
    case SelectArgType_Five
    case SelectArgType_Ten
    case SelectArgType_Fifth
}

class CreateOCCodeVM: NSObject {
    
    var btnClose = MutableProperty(NSButton())
    var btnDo = MutableProperty(NSButton())
    var btnPopThing = MutableProperty(NSPopUpButton())
    var btnPopArg = MutableProperty(NSPopUpButton())
    var tvMain = MutableProperty(NSTextView())
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
                self?.tvMain.value.string = ""
                Alert.show(title: "请选择", window: (NSApplication.shared.windows.last)!, block: {
                    
                });
            }else{
                if self?.selectType.value == SelectType.SelectType_Default && self?.selectArgType.value == SelectArgType.SelectArgType_Default {
                    Alert.show(title: "请选择", window: (NSApplication.shared.windows.last)!, block: {
                        
                    });
                }
                else if self?.selectType.value == SelectType.SelectType_Corner && self?.selectArgType.value == SelectArgType.SelectArgType_Default {
                Alert.show(title: "请选择", window: (NSApplication.shared.windows.last)!, block: {
                    
                });
                    
                }
                else{
                   self?.outputCode()
                }
            }
        }
        
        
        selectType.signal.observeValues {[weak self] (type) in
            if type != .SelectType_Default && type != .SelectType_Hex {
                self?.btnPopArg.value.isHidden = false
            }else{
                self?.btnPopArg.value.isHidden = true
            }
            
        }
        
        selectArgType.signal.observeValues { (type) in
            
        }
        
        btnPopArg.signal.observeValues {[weak self] (btn) in
            print("btn tag = \(btn.tag)")
            self?.btnDoDo = btn
        }
        
        
    }
    
    private func outputCode(){
        
        switch selectType.value {
        case .SelectType_Corner:
            codeForCorner()
            break
        case.SelectType_Hex:
            codeForHex()
            break
        default:
            break
        }
    }
    
    fileprivate func codeForCorner(){
        let str = "view.layer.masksToBounds = true;\nview.layer.cornerRadius = \((btnPopArg.value.selectedItem?.title.cgFloat())!);";
        tvMain.value.string = str;
    }
    
    fileprivate func codeForHex(){
        let str = "#define kUIColorFromRGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]";
        tvMain.value.string = str;
    }

}
