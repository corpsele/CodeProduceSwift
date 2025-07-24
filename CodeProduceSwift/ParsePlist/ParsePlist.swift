//
//  Untitled.swift
//  CodeProduceSwift
//
//  Created by eport on 2025/7/24.
//  Copyright © 2025 eport2. All rights reserved.
//

import RxSwift
import RxCocoa

class ParsePlist: NSViewController {
    private var tvContent: NSTextView?
    private var btnClose: NSButton?
    
    func setData(_ dic: Dictionary<String, Any>) {
        DispatchQueue.main.async { [unowned self] in
            print("dic jsonString = \(dic.jsonString())")
            tvContent?.string = dic.jsonString(prettify: true) ?? ""
        }
        
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Plist"
        
        initViews()
    }
    
    private func initViews() {
        tvContent = NSTextView()
        tvContent?.isEditable = false
        self.view.addSubview(tvContent!)
        tvContent?.snp.makeConstraints({ make in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50)
        })
        
        btnClose = NSButton()
        btnClose?.title = "Close"
        self.view.addSubview(btnClose!)
        btnClose?.snp.makeConstraints({ make in
            make.top.equalTo((tvContent?.snp.bottom)!)
            make.left.right.bottom.equalTo(self.view)
        })
        btnClose?.rx.tap.subscribe({ [unowned self] _ in
            self.dismiss(self)
        })
    }
}
