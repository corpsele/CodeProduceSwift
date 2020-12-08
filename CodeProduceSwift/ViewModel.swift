//
//  ViewModel.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2019/12/3.
//  Copyright © 2019 eport2. All rights reserved.
//

import Cocoa
import ReactiveCocoa
import ReactiveSwift

class ViewModel: NSObject {
    
    var btnWindowAction = Action<Void, Bool, Never> { (input: Void) -> SignalProducer<Bool, Never> in
        return SignalProducer{ (observer, disposeble) in
            observer.send(value: true)
            observer.sendCompleted()
        }
    }
    
    var btnFileAction = Action<Void, Bool, Never> { (input: Void) -> SignalProducer< Bool , Never> in
       return SignalProducer{ (observer, disposable) in
           observer.send(value: true)
           observer.sendCompleted()
       }
    }
    
    var btnCodeAction = Action<Void, Bool, Never> { (input: Void) -> SignalProducer< Bool , Never> in
       return SignalProducer{ (observer, disposable) in
           observer.send(value: true)
           observer.sendCompleted()
       }
    }
    
    var btnCryptAction = Action<Void, Bool, Never> { (input: Void) -> SignalProducer<Bool, Never> in
        return SignalProducer { (observer, disposable) in
            observer.send(value: true)
            observer.sendCompleted()
        }
    }

    override init(){
        super.init();

    }
}
