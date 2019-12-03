//
//  CreateOCFileVM.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2019/12/3.
//  Copyright © 2019 eport2. All rights reserved.
//

import Cocoa

import SwifterSwift
import ReactiveSwift
import ReactiveCocoa

class CreateOCFileVM: NSObject {
    var btnCloseAction = Action<Void, Bool, Never> { (input: Void) -> SignalProducer< Bool , Never> in
       return SignalProducer{ (observer, disposable) in
           observer.send(value: true)
           observer.sendCompleted()
       }
    }
}
