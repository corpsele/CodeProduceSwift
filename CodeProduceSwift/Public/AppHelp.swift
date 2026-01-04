import Cocoa
import Swinject
import SwinjectStoryboard

let shared = NSApplication.shared.delegate as? AppDelegate

var container: Container = {
    let container = Container()
    
    container.register(WebModel.self) { r in
        WebModel("https://www.baidu.com")
    }
    
    container.register(BGWebView.self) { r in
        let webView = BGWebView(r.resolve(WebModel.self)!)
        return webView
    }
    
    container.register(BWebController.self) { r in
        let vc = BWebController()
        vc.webView = r.resolve(BGWebView.self)
        return vc
    }
    
    return container
}()

struct  AppInfo {
    
    static let infoDictionary = Bundle.main.infoDictionary
    
    static let appDisplayName: String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String //App 名称
    
    static let appBundleName: String = Bundle.main.infoDictionary?["CFBundleName"] as! String // app名字 (=项目名)
    
    static let bundleIdentifier:String = Bundle.main.bundleIdentifier! // Bundle Identifier
    
    static let appVersion:String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String// App 版本号
    
    static let buildVersion : String = Bundle.main.infoDictionary! ["CFBundleVersion"] as! String //Bulid 版本号
    
    static var mainWindowRect : NSRect = .zero

}

struct Alert {
    static func show(title: String, window: NSWindow, block: @escaping ()->()){
        
        let alert = NSAlert();
        alert.messageText = title;
        alert.addButton(withTitle: "OK")
        alert.alertStyle = .informational
        alert.beginSheetModal(for: window) { (res) in
            block();
        }
//        let res = alert.runModal()
        
    }
}

struct Utils {

    static func dataToDictionary(from data: Data) -> [String: Any]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let dictionary = jsonObject as? [String: Any] {
                print("utils datatodictionary = \(dictionary)")
                return dictionary
            }
        } catch {
            print("JSON conversion failed: \(error)")
        }
        return nil
    }
    
    /*
     * 磁盘总容量 /
     * print("磁盘总容量: \(getDiskCapacity())")
     */
    static func getDiskCapacity() -> String {
        let fileManager = FileManager.default
        
        do {
            // 获取根目录 "/" 的属性
            let attributes = try fileManager.attributesOfFileSystem(forPath: "/")
            
            // 提取总容量
            if let totalSize = attributes[.systemSize] as? UInt64 {
                let bytesInMB = Double(totalSize) / 1024.0 / 1024.0
                
                // 逻辑：如果大于等于 1024 MB (1 GB)，则显示 GB，否则显示 MB
                if bytesInMB >= 1024 {
                    let sizeInGB = bytesInMB / 1024.0
                    return String(format: "%.2f GB", sizeInGB)
                } else {
                    return String(format: "%.2f MB", bytesInMB)
                }
            }
        } catch {
            return "Error: \(error.localizedDescription)"
        }
        
        return "Unknown"
    }

    /*
     * 磁盘总容量
     * print("磁盘总容量: \(getDiskCapacityFormatted())")
     */
    static func getDiskCapacityFormatted() -> String {
        let fileManager = FileManager.default
        
        do {
            let attributes = try fileManager.attributesOfFileSystem(forPath: "/")
            
            if let totalSize = attributes[.systemSize] as? UInt64 {
                // 创建格式化器
                let formatter = ByteCountFormatter()
                
                // 限制允许的单位：只允许 GB 和 MB
                formatter.allowedUnits = [.useGB, .useMB]
                
                // 设置计数样式 (file 或 binary)
                // .file 使用 1000 进制 (1GB = 1000MB，与 Finder 显示一致)
                // .binary 使用 1024 进制
                formatter.countStyle = .file
                
                return formatter.string(fromByteCount: Int64(totalSize))
            }
            // 获取可用空间
            if let freeSize = attributes[.systemFreeSize] as? UInt64 {
                let freeSizeMB = Double(freeSize) / 1024.0 / 1024.0
                print("可用空间: \(freeSizeMB >= 1024 ? String(format: "%.2f GB", freeSizeMB/1024) : String(format: "%.2f MB", freeSizeMB))")
                return "可用空间: \(freeSizeMB >= 1024 ? String(format: "%.2f GB", freeSizeMB/1024) : String(format: "%.2f MB", freeSizeMB))"
            }

        } catch {
            return "Error"
        }
        
        return "Unknown"
    }

    /*
     * 磁盘可用容量
     * print("磁盘总容量: \(getDiskCapacityFormatted())")
     */
    static func getDiskFreeCapacityFormatted() -> String {
        let fileManager = FileManager.default
        
        do {
            let attributes = try fileManager.attributesOfFileSystem(forPath: "/")
            
            // 获取可用空间
            if let freeSize = attributes[.systemFreeSize] as? UInt64 {
                let freeSizeMB = Double(freeSize) / 1024.0 / 1024.0
                print("可用空间: \(freeSizeMB >= 1024 ? String(format: "%.2f GB", freeSizeMB/1024) : String(format: "%.2f MB", freeSizeMB))")
                return "可用空间: \(freeSizeMB >= 1024 ? String(format: "%.2f GB", freeSizeMB/1024) : String(format: "%.2f MB", freeSizeMB))"
            }

        } catch {
            return "Error"
        }
        
        return "Unknown"
    }


}


//@objc protocol HelpDelegate {
//    func changeTitle(title: String)
//}
