//
//  BGWebView.swift
//  CodeProduceSwift
//
//  Created by corpsele_n on 2026/1/3.
//  Copyright © 2026 eport2. All rights reserved.
//

import WebKit

class BGWebView: GWebView {
    private var webConfig: WKWebViewConfiguration = WKWebViewConfiguration()
    private var userContentController: WKUserContentController = WKUserContentController()
    private var webPagePreferences: WKWebpagePreferences = WKWebpagePreferences()
    
    init(_ strUrl: String) {
        super.init(strUrl, self.webConfig)
    }
    
    init(_ webModel: WebModel) {
        super.init(webModel, self.webConfig)
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func initViews() {
        super.initViews()
        
        webConfig.userContentController = userContentController
        webConfig.allowsAirPlayForMediaPlayback = true
        webConfig.defaultWebpagePreferences = webPagePreferences
        if #available(macOS 11.0, *) {
            webPagePreferences.allowsContentJavaScript = true
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    public func startLoad(){
        let urlRequest = URLRequest(urlString: self.strUrl ?? "")
        if let r = urlRequest {
            self.load(r)
        }
    }
    
    
}
