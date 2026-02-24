//
//  SwiftUIPresenter.swift
//  CodeProduceSwift
//
//  Created by corpsele_n on 2026/2/24.
//  Copyright © 2026 eport2. All rights reserved.
//  Swift 交互 SwiftUI

import AppKit
import SwiftUI

/// 通用的 SwiftUI 弹窗管理器
class SwiftUIPresenter<Content: SwiftUI.View> {
    
    // 持有 HostingController，防止被释放
    private var hostingController: NSHostingController<Content>?
    
    private let rootView: Content
    
    private let rect: CGRect
    
    init(rootView: Content, _ rect: CGRect = .init(x: 0, y: 0, width: NSScreen.main?.visibleFrame.size.width ?? .leastNormalMagnitude, height: NSScreen.main?.visibleFrame.size.height ?? .leastNormalMagnitude)) {
        self.rootView = rootView
        self.rect = rect
    }
    
    /// 作为 Sheet 展示
    func presentAsSheet(on parent: NSViewController) {
        let controller = NSHostingController(rootView: rootView)
        self.hostingController = controller
        parent.presentAsSheet(controller)
    }
    
    /// 作为 Popover 展示
    func presentAsPopover(on parent: NSViewController, from sourceView: NSView, edge: NSRectEdge = .maxY) {
        let controller = NSHostingController(rootView: rootView)
        self.hostingController = controller
        parent.present(controller, asPopoverRelativeTo: sourceView.bounds, of: sourceView, preferredEdge: edge, behavior: .transient)
    }
    
    /// 作为Modal弹出
    func presentAsModal(on parent: NSViewController) {
        let controller = NSHostingController(rootView: rootView)
        self.hostingController = controller
        self.hostingController?.view.frame = rect
        parent.presentAsModalWindow(controller)
    }
    
    /// 手动关闭
    func dismiss() {
        hostingController?.dismiss(nil)
        hostingController = nil
    }
}
