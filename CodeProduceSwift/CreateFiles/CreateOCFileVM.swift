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
    
    var (createFileSignal, createFileObserver) = Signal<Void, Never>.pipe();
    
    let tfText = MutableProperty<String>("")
    
    var textSignal:SignalProducer<((String) -> Void), Never>!
    
    var strFileName = ""
    var filePath = ""
    
    override init() {
        super.init()
        
        textChangedSignal.observeValues { (tf) in
            print("vm output = \(tf.stringValue)");
        }
        Property.init(tfText).map{ tf in
            print(tf)
        }
        tfText.signal.observeValues {[weak self] (str) in
            self?.strFileName = str;
            print("property signal = \(str)")
        }
        
        textSignal.map{ (sign) in
            sign.map{ (str) in
                
            }
        }
        
        createFileSignal.observeValues {[weak self] _ in
            self?.createVCH(fileName: (self?.strFileName)!)
            self?.createVCM(fileName: (self?.strFileName)!)
            self?.createVMH(fileName: (self?.strFileName)!)
            self?.createVMM(fileName: (self?.strFileName)!)
            let task = Process()
            task.launchPath = "/usr/bin/env"
            task.arguments = ["open", (self?.filePath)!]
            task.launch()
            task.waitUntilExit()
            print("task return code \(task.terminationStatus) and reason \(task.terminationReason)")
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
            filePath = path
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
            let url = writeFile(fileName: fileName+"VC.h");
            let manager = FileManager.default;
                    //定义可变数据变量
                    let data = NSMutableData()
                    //向数据对象中添加文本，并制定文字code
            data.append("#import <Foundation/Foundation.h>\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            let tfName =
            data.append("@interface \(strFileName)VC: UIViewController\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            
            data.append("@end".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            
            if !manager.fileExists(atPath: url.path!) {
                manager.createFile(atPath: url.path!, contents: data as Data, attributes: nil);
            }
            
                    //用data写文件
            data.write(toFile: url.path!, atomically: true)
        }
    
    // MARK: 创建VM .h
    private func createVMH(fileName: String)
            {
                let url = writeFile(fileName: fileName+"VM.h");
                let manager = FileManager.default;
                        //定义可变数据变量
                        let data = NSMutableData()
                        //向数据对象中添加文本，并制定文字code
                data.append("#import <Foundation/Foundation.h>\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
    //            let tfName =
                data.append("@interface \(strFileName)VM: NSObject\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("@end".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                if !manager.fileExists(atPath: url.path!) {
                    manager.createFile(atPath: url.path!, contents: data as Data, attributes: nil);
                }
                
                        //用data写文件
                data.write(toFile: url.path!, atomically: true)
            }
    
    // MARK: 创建VC .m 文件
            private func createVCM(fileName: String)
            {
                let url = writeFile(fileName: fileName+"VC.m");
                let manager = FileManager.default;
                        //定义可变数据变量
                        let data = NSMutableData()
                        //向数据对象中添加文本，并制定文字code
                data.append("#import \"\(strFileName)VC.h\"\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("#import \"\(strFileName)VM.h\"\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
    //            let tfName =
                data.append("@interface \(strFileName)VC()\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("@property (nonatomic, strong) \(strFileName)VM *vm;\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("@end\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("@implementation \(strFileName)VC\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("- (id)init\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("{\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  self = [super init];\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("  if(self)\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  {\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("    vm = [\(strFileName)VM new];\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  }\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  return self;\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("}\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("- (id)initWithFrame:(CGRect)frame\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("{\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  self = [super initWithFrame:frame];\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  if (self) {\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  }\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  return self;\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("}\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("- (void)viewDidLoad {\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  [super viewDidLoad];\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("}\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    data.append("- (void)viewWillAppear:(BOOL)animated\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("{\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  [super viewWillAppear:animated];\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("}\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                
                
                data.append("@end".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                if !manager.fileExists(atPath: url.path!) {
                    manager.createFile(atPath: url.path!, contents: data as Data, attributes: nil);
                }
                
                        //用data写文件
                data.write(toFile: url.path!, atomically: true)
            }
    
    // MARK: 创建VM .m 文件
            private func createVMM(fileName: String)
            {
                let url = writeFile(fileName: fileName+"VM.m");
                let manager = FileManager.default;
                        //定义可变数据变量
                        let data = NSMutableData()
                        //向数据对象中添加文本，并制定文字code
                
    //            let tfName =
                data.append("@interface \(strFileName)VM()\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("@end\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("@implementation \(strFileName)VM\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("- (id)init\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("{\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  self = [super init];\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                data.append("  if(self)\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  {\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  }\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("  return self;\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                data.append("}\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                
                
                
                data.append("@end".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                if !manager.fileExists(atPath: url.path!) {
                    manager.createFile(atPath: url.path!, contents: data as Data, attributes: nil);
                }
                
                        //用data写文件
                data.write(toFile: url.path!, atomically: true)
            }
}
