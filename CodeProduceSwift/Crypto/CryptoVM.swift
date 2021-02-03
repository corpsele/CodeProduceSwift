//
//  CryptoVM.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2021/2/2.
//  Copyright © 2021 eport2. All rights reserved.
//

import Cocoa
import CryptoSwift

class CryptoVM: NSObject {
    var inputText: String? = "inputText"
    var selectedIndex = MutableProperty<Int>(0)
    
    let closeAction = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in 
        return SignalProducer { (observer, disposable) in
            observer.sendCompleted()
        }
    }
    
    let enAction = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            observer.sendCompleted()
        }
        
    }
    
    override init() {
        super.init()
        
        
    }
    
    private func md5En() -> String {
        guard let str = inputText else {
            return ""
        }
        print(str)
        let data = str.data(using: .utf8)?.md5() ?? Data()
        let tmp = data.toHexString()
        return tmp
    }
    
    private func crcEn() -> String {
        guard let str = inputText else {
            return ""
        }
        print(str)
        let data = str.data(using: .utf8)?.crc32() ?? Data()
        let tmp = data.toHexString()
        return tmp
    }
    
    private func shaEn() -> String {
        guard let str = inputText else {
            return ""
        }
        print(str)
        let data = str.data(using: .utf8)?.sha256() ?? Data()
        let tmp = data.toHexString()
        return tmp
    }
    
    open func enMethod() -> String {
        switch selectedIndex.value {
        case 0:
            return md5En()
        case 1:
            return crcEn()
        case 2:
            return shaEn()
        default:
            return ""
        }
    }

}
