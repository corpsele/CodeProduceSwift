//
//  GWebWindow.swift
//  CodeProduceSwift
//
//  Created by corpsele_n on 2026/1/3.
//  Copyright © 2026 eport2. All rights reserved.
//

import WebKit

class BWebController: NSViewController {
    @IBOutlet var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "BiliBili"
        
        initViews()
    }
    
    private func initViews() {
        
        
        self.view.addSubview(bWebView)
        bWebView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        DispatchQueue.main.async {
            self.bWebView.startLoad()
        }
//        let request = URLRequest(urlString: "https://www.baidu.com")
//        if let r = request {
//            self.webView?.load(r)
//        }
        
    }
    
    
    lazy var bWebView: BGWebView = {
       let webView = BGWebView("https://www.bilibili.com")
        return webView
    }()
}
