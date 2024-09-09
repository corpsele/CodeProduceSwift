//
//  SourceEditorCommand.swift
//  EditPlugin
//
//  Created by eport on 2023/1/12.
//  Copyright © 2023 eport2. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        let firstSelectObject = invocation.buffer.selections.firstObject as! XCSourceTextRange
        
        let start = firstSelectObject.start.line
        
        let end = firstSelectObject.end.line
        
        print("invocation.buffer.selections = \(invocation.buffer.selections)")
        
        
        print("perform XCSourceEditorCommandInvocation")
        
        completionHandler(nil)
    }
    
}
