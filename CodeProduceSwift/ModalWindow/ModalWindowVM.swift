//
//  ModalWindowVM.swift
//  CodeProduceSwift
//
//  Created by corpsele_n on 2026/2/24.
//  Copyright © 2026 eport2. All rights reserved.
//

class ModalWindowVM {
    // 第一个菜单项的行为
    lazy var menuAction: Action<(), (), Never> = Action { [weak self] in
        print("item action ")
        return SignalProducer.empty
    }
}
