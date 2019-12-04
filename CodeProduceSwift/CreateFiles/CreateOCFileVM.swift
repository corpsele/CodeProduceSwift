//
//  CreateOCFileVM.swift
//  CodeProduceSwift
//
//  Created by eport2 on 2019/12/3.
//  Copyright © 2019 eport2. All rights reserved.
//

import Cocoa

import SwifterSwift
import ReactiveSwift
import ReactiveCocoa

class CreateOCFileVM: NSObject {
    var btnCloseAction = Action<Void, Bool, Never> { (input: Void) -> SignalProducer< Bool , Never> in
       return SignalProducer{ (observer, disposable) in
           observer.send(value: true)
           observer.sendCompleted()
       }
    }
    
    var textAction = Action<(String), Bool, Never> { (input: (String)) -> SignalProducer< Bool , Never> in
       return SignalProducer{ (observer, disposable) in
           observer.send(value: true)
           observer.sendCompleted()
       }
    }
    
    var (textChangedSignal, textChangedObserver) = Signal<NSTextField, Never>.pipe();
    
    let tfText = MutableProperty<String>("")
    
    var textSignal:SignalProducer<((String) -> Void), Never>!
    
    override init() {
        textChangedSignal.observeValues { (tf) in
            print("vm output = \(tf.stringValue)");
        }
        Property.init(tfText).map{ tf in
            print(tf)
        }
        tfText.signal.observeValues { (str) in
            print("property signal = \(str)")
        }
        
        textSignal.map{ (sign) in
            sign.map{ (str) in
                
            }
        }
    }
    
        private func writeFile(fileName: String) -> NSURL
        {
             //取得当前应用下路径
            let sp = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentationDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
                    
                    //循环取得路径
                    for file in sp {
                        print(file)
                    }
            
            
                    //设定路径
            let path = "/Users/\(NSUserName())/Downloads/\(AppInfo.appBundleName)/";
    //        let path = NSHomeDirectory() + "/\(AppInfo.appBundleName)";
    //        let fileName = "data.txt";
            let url: NSURL = NSURL(fileURLWithPath: path+fileName);
            var isDirectory = ObjCBool(true);
            
            let manager = FileManager.default;
            if !manager.fileExists(atPath: path, isDirectory: &isDirectory) {
                do {
                    try manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil);
                    
                } catch let err {
                    print("err = \(err)")
                }
                
            }
            
            return url
                    
            
            
                    
    //                //从url里面读取数据，读取成功则赋予readData对象，读取失败则走else逻辑
    //                if let readData = NSData(contentsOfFile: url.path!) {
    //                    //如果内容存在 则用readData创建文字列
    //                    print(String(data: readData as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)))
    //                } else {
    //                    //nil的话，输出空
    //                    print("Null")
    //                }
            
        }
        
        // MARK: 创建VC .h 文件
        private func createVCH(fileName: String)
        {
            let url = writeFile(fileName: fileName);
            let manager = FileManager.default;
                    //定义可变数据变量
                    let data = NSMutableData()
                    //向数据对象中添加文本，并制定文字code
            data.append("#import <Foundation/Foundation.h>".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            let tfName =
            data.append("@interface ".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            
            if !manager.fileExists(atPath: url.path!) {
                manager.createFile(atPath: url.path!, contents: data as Data, attributes: nil);
            }
            
                    //用data写文件
            data.write(toFile: url.path!, atomically: true)
        }
}
