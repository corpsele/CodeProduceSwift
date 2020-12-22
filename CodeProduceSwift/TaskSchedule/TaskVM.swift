//
//  TaskVM.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2020/12/21.
//  Copyright © 2020 eport2. All rights reserved.
//

import Cocoa

class TaskVM: NSObject {
    var dateSignal = Signal<Void, Never>.empty
    var dateSignalObserver = Signal<Void, Never>.Observer()
    let sendUpdate: MutableProperty<NSControl.StateValue>?
    
    override init() {
        
        sendUpdate = MutableProperty<NSControl.StateValue>(.on)
        
        super.init()
        
        dateSignal = Signal<Void, Never> {[unowned self] observer, disposable in
            self.dateSignalObserver = observer
            observer.send(value: ())
            observer.sendCompleted()
        }
        updateDate()
    }
    
    func updateDate() {
        self.sendUpdate?.signal.observeValues({[unowned self] (state) in
            if state == .on {
                self.startTimer()
            }else{
                self.stopTimer()
            }
        })
        
        
    }
    
    var timer: DispatchSourceTimer?
    private func startTimer() {
        let queue = DispatchQueue(label: "com.firm.app.timer", attributes: .concurrent)
//        timer?.cancel()        // cancel previous timer if any
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(5))
        // or, in Swift 3:
        //
        // timer?.scheduleRepeating(deadline: .now(), interval: .seconds(5), leeway: .seconds(1))
        timer?.setEventHandler { [unowned self] in // `[weak self]` only needed if you reference `self` in this closure and you want to prevent strong reference cycle
//            print(Date())
            
            DispatchQueue.main.async {
                self.sendUpdate?.modify({ (_) in
                    
                })
            }
        }
        timer?.resume()
    }
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }

}
