import Cocoa

let shared = NSApplication.shared.delegate as? AppDelegate

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
}


//@objc protocol HelpDelegate {
//    func changeTitle(title: String)
//}
