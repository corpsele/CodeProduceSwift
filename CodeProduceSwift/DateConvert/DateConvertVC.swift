//
//  DateConvertVC.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2021/2/5.
//  Copyright © 2021 eport2. All rights reserved.
//

import Cocoa

class DateConvertVC: NSViewController, NSTextViewDelegate {
    
    @IBOutlet weak var txtTime: NSScrollView!
    @IBOutlet weak var txtDate: NSScrollView!
    @IBOutlet weak var btnTimeToDate: NSButton!
    @IBOutlet weak var btnDateToTime: NSButton!
    @IBOutlet weak var btnClose: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        btnTimeToDate.reactive.states.observeValues {[unowned self] (state) in
            self.timeToDateInterval()
        }
        
        btnDateToTime.reactive.states.observeValues {[unowned self] (state) in
            self.dateToTimeInterval()
        }
        
        if let tv = txtDate.documentView as? NSTextView {
            tv.delegate = self
        }
        
        
        btnClose.reactive.states.observeValues {[unowned self] (state) in
            self.dismiss(self)
        }
        
    }
    
    private func dateToTimeInterval() {
        var date = Date()
        if let tv = txtDate.documentView as? NSTextView {
            date = dateFormat.date(from: tv.string) ?? Date()
        }
        if let tv = txtTime.documentView as? NSTextView {
            tv.string = date.timeIntervalSince1970.string
        }
    }
    
    private func timeToDateInterval() {
        var date = Date()
        if let tv = txtTime.documentView as? NSTextView {
            date = Date(timeIntervalSince1970: TimeInterval(tv.string) ?? TimeInterval())
        }
        if let tv = txtDate.documentView as? NSTextView {
            tv.string = dateFormat.string(from: date)
        }
    }
    
    lazy var dateFormat: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormat
    }()

    
}
