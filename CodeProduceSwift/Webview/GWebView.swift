//
//  GWebView.swift
//  CodeProduceSwift
//
//  Created by corpsele_n on 2026/1/3.
//  Copyright © 2026 eport2. All rights reserved.
//

import Foundation
import WebKit

class GWebView: WKWebView, WKNavigationDelegate, WKUIDelegate {
    public var strUrl: String?
    public var webViewConfiguration: WKWebViewConfiguration?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    init(_ webModel: WebModel, _ webViewConfiguration: WKWebViewConfiguration){
        super.init(frame: .zero, configuration: webViewConfiguration)
        
        self.strUrl = webModel.strUrl
        self.webViewConfiguration = webViewConfiguration
        self.navigationDelegate = self
        self.uiDelegate = self
        
        initViews()
    }
    
    init(_ strUrl: String, _ webViewConfiguration: WKWebViewConfiguration){
        super.init(frame: .zero, configuration: webViewConfiguration)
        
        self.strUrl = strUrl
        self.webViewConfiguration = webViewConfiguration
        self.navigationDelegate = self
        self.uiDelegate = self
        
        initViews()
    }
    
    public func initViews() {
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        print("error = \(error)")
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping @MainActor (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let serverTrust = challenge.protectionSpace.serverTrust {
                // 创建一个信任凭证
                let credential = URLCredential(trust: serverTrust)
                
                // 告诉 WebView 使用这个凭证
                completionHandler(.useCredential, credential)
            } else {
                // 其他情况使用默认处理
                completionHandler(.performDefaultHandling, nil)
            }
        }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        return .allow
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences) {
        return (.allow, preferences)
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        self.reload()
    }
    
}
