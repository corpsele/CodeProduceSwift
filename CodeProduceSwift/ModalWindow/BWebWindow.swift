//
//  BWebWindow.swift
//  CodeProduceSwift
//
//  Created by corpsele_n on 2026/1/3.
//  Copyright © 2026 eport2. All rights reserved.
//

class BWebWindow: NSWindow, NSWindowDelegate {
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        
        initView()
    }
    
    private func initView(){
        self.contentView?.addSubview(bWebView)
        bWebView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView!)
        }
        
        DispatchQueue.main.async {
            self.bWebView.startLoad()
        }
    }
    
    lazy var bWebView: BGWebView = {
       let webView = BGWebView("https://www.bilibili.com")
        return webView
    }()
}
