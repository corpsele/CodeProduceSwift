import Cocoa

struct  AppInfo {
    
    static let infoDictionary = Bundle.main.infoDictionary
    
    static let appDisplayName: String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String //App 名称
    
    static let appBundleName: String = Bundle.main.infoDictionary?["CFBundleName"] as! String // app名字 (=项目名)
    
    static let bundleIdentifier:String = Bundle.main.bundleIdentifier! // Bundle Identifier
    
    static let appVersion:String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String// App 版本号
    
    static let buildVersion : String = Bundle.main.infoDictionary! ["CFBundleVersion"] as! String //Bulid 版本号

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


//@objc protocol HelpDelegate {
//    func changeTitle(title: String)
//}
