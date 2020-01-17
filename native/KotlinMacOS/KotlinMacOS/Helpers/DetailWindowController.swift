//
//  DetailWindowController.swift
//  TryMacOS
//
//  Created by Dmitri  on 12/14/19.
//  Copyright © 2019 spb. All rights reserved.
//

import Cocoa
import SwiftUI


class DetailWindowController<RootView : View>: NSWindowController {
    convenience init(rootView: RootView) {
        let hostingController = NSHostingController(rootView: rootView.frame(width: 480, height: 647))
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 480, height: 647))
        self.init(window: window)
    }
}

