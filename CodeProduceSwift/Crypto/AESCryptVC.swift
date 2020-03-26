//
//  AESCryptVC.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2020/3/23.
//  Copyright © 2020 eport2. All rights reserved.
//

import Cocoa

import RxSwift
import ReactiveSwift
import ReactiveCocoa

enum CryptType {
    case CryptType_DE
    case CryptType_EN
}

class AESCryptVC: NSViewController {
    
    @IBOutlet weak var sourceTV: NSScrollView!
    @IBOutlet weak var newTV: NSScrollView!
    @IBOutlet weak var btnEncrypt: NSButton!
    @IBOutlet weak var btnDecrypt: NSButton!
    @IBOutlet weak var btnClose: NSButton!
    @IBOutlet weak var btnCopyAbove: NSButton!
    @IBOutlet weak var btnCopyBottom: NSButton!
    @IBOutlet weak var btnPasteAbove: NSButton!
    @IBOutlet weak var btnPasteBottom: NSButton!
    @IBOutlet weak var btnCleanAbove: NSButton!
    @IBOutlet weak var btnCleanBottom: NSButton!
    
    let vm = AESCryptVM()
    let board = NSPasteboard.general
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let textV = newTV.documentView as? NSTextView {
            textV.isAutomaticQuoteSubstitutionEnabled = false
        }
        
        if let textV = sourceTV.documentView as? NSTextView {
            textV.isAutomaticQuoteSubstitutionEnabled = false
        }
        
//        btnEncrypt.reactive.pressed?.execute { [weak self] in
//            let textView = self?.sourceTV.documentView as? NSTextView
//            let result = self?.crypt(str: textView?.string ?? "", type: CryptType.CryptType_EN)
//            self?.newTV.insertText(result!)
//        }

        btnEncrypt.reactive.pressed = CocoaAction<NSButton>(vm.btnEncryptAction) { [weak self] (sender) in
            self?.newTV.documentView?.insertText(self?.vm.outputText ?? "")
        }
        
//        btnDecrypt.reactive.pressed?.execute { [weak self] in
//            let textView = self?.sourceTV.documentView as? NSTextView
//            let result = self?.crypt(str: textView?.string ?? "", type: CryptType.CryptType_DE)
//            self?.newTV.insertText(result!)
//        }
        if let textV = sourceTV.documentView as? NSTextView {
            vm.signalString = textV.reactive.continuousStringValues
        }
        btnDecrypt.reactive.pressed = CocoaAction<NSButton>(vm.btnDecryptAction) { [weak self] (sender) in
//            self?.newTV.documentView?.insertText(self?.vm.outputText ?? "")
        }
        
        vm.getOutputText = { [weak self] in
            self?.newTV.documentView?.insertText(self?.vm.outputText ?? "")
        }
        
        btnClose.reactive.pressed = CocoaAction<NSButton>(vm.btnCloseAction) { [weak self] (sender) in
            self?.dismiss(self)
        }
        
        btnPasteAbove.reactive.pressed = CocoaAction<NSButton>(vm.btnPasteAbove) { [weak self] (sender) in
            
            self?.sourceTV.documentView?.insertText(self?.board.string(forType: .string) ?? "")
            
        }
        
        btnCopyBottom.reactive.pressed = CocoaAction<NSButton>(vm.btnCopyAbove) { [weak self] (sender) in
            if let textV = self?.newTV.documentView as? NSTextView {
                self?.board.clearContents()
                self?.board.writeObjects([textV.string as NSString])
            }
        }
        
        btnPasteBottom.reactive.pressed = CocoaAction<NSButton>(vm.btnPasteBottom) { [weak self] (sender) in
            self?.newTV.documentView?.insertText(self?.board.string(forType: .string) ?? "")
        }
        
        btnCleanAbove.reactive.pressed = CocoaAction<NSButton>(vm.btnCleanAbove) { [weak self] sender in
            if let textV = self?.sourceTV.documentView as? NSTextView {
                textV.string = ""
            }
            
        }
        
        btnCleanBottom.reactive.pressed = CocoaAction<NSButton>(vm.btnCleanBottom) { [weak self] sender in
            if let textV = self?.newTV.documentView as? NSTextView {
                textV.string = ""
            }
            
        }
        
        
        vm.addObserver()
    }
    
    fileprivate func crypt(str: String, type: CryptType) -> String{
        var result = ""
        switch type {
        case .CryptType_DE:
            result = IUMEncryptor.decryptDES(str)
        case .CryptType_EN:
            result = IUMEncryptor.encryptDES(str)
        
        }
        return result
    }

    @IBAction func actionDecryptEvent(_ sender: Any) {
    }
}
