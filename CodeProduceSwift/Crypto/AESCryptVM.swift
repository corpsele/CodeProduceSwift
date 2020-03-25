//
//  AESCryptVM.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2020/3/23.
//  Copyright © 2020 eport2. All rights reserved.
//

import Cocoa

import ReactiveCocoa
import ReactiveSwift
import RxSwift

class AESCryptVM: NSObject {
    private var inputText: String?
    private(set) var outputText : String!
    var getOutputText:  (() -> ())?

    var btnCloseAction = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            observer.sendCompleted()
        }
    }
    
    var btnEncryptAction = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            
            observer.sendCompleted()
        }
        
    }
    
    var signalString: Signal<String, Never>!
    
    var btnDecryptAction = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            
            observer.sendCompleted()
        }
        
    }
    
    var btnCopyAbove = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            observer.sendCompleted()
        }
        
    }
    
    var btnPasteAbove = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            observer.sendCompleted()
        }
        
    }
    
    var btnPasteBottom = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            observer.sendCompleted()
        }
        
    }
    
    var btnCopyBottom = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            observer.sendCompleted()
        }
        
    }
    
    var btnCleanAbove = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            observer.sendCompleted()
        }
    }
    
    var btnCleanBottom = Action<Void, Void, Never> { (input: Void) -> SignalProducer<Void, Never> in
        return SignalProducer { (observer, disposable) in
            observer.sendCompleted()
        }
    }
    
    override init() {
        super.init()

    }
    
    func addObserver(){
        btnDecryptAction.events.observeValues {[weak self] (event) in
            self?.outputText = self?.crypt(str: self?.inputText ?? "", type: .CryptType_DE)
            if let block = self?.getOutputText {
                block()
            }
        }
        
        signalString.observeValues {[weak self] (str) in
            self?.inputText = str
            
        }
        
        btnEncryptAction.events.observeValues {[weak self] (event) in
            self?.outputText = self?.crypt(str: self?.inputText ?? "", type: .CryptType_EN)
        }
    }
    
    fileprivate func crypt(str: String, type: CryptType) -> String{
        var result = ""
        switch type {
        case .CryptType_DE:
            result = IUMEncryptor.decryptDES(str)
        case .CryptType_EN:
            result = IUMEncryptor.encryptDES(str)
        
        }
        return result
    }
}
