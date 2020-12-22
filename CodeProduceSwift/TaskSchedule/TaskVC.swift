        //
//  TaskVC.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2020/12/21.
//  Copyright © 2020 eport2. All rights reserved.
//

import Cocoa

class TaskVC: NSViewController {
    @IBOutlet var btnClose: NSButton!
    @IBOutlet var datePicker: NSDatePicker!
    @IBOutlet var checkUpdate: NSButton!
    
    let vm = TaskVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        let bcAction = Action<Void, Void, Never> { (_: Void) -> SignalProducer<Void, Never> in
            SignalProducer { observer, _ in
                observer.send(value: ())
                observer.sendCompleted()
            }
        }

        let btnCloseAction = CocoaAction<NSButton>(bcAction)
        btnClose.reactive.pressed = btnCloseAction
        bcAction.values.observeValues {[unowned self] () in
            self.dismiss(nil)
        }
        
        vm.sendUpdate?.value = .on
        
        vm.sendUpdate?.signal.observeValues({ (flag) in
            DispatchQueue.main.async {
                anim(constraintParent: self.datePicker) { (settings) -> (animClosure) in
                    // settings...
                    settings.duration = 1
                    settings.ease = .easeInOutSine
                    return {
                        // animation block
                        self.datePicker.dateValue = Date()
                    }
                }
                
            }
        })
        
        checkUpdate.action = #selector(checkUpdateAction(sender:))
        
    }
    
    @objc func checkUpdateAction(sender: NSButton) {
        vm.sendUpdate?.value = sender.state
    }

    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
}
