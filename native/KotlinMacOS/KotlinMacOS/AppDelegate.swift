//
//  AppDelegate.swift
//  TryMacOS
//
//  Created by Dmitri  on 12/12/19.
//  Copyright © 2019 spb. All rights reserved.
//

import Cocoa
import SwiftUI
import SharedCode

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        /* var ideaViewModel2 = IdeasViewModel(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"))*/
        //ideaViewModel2.loadIdeas()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

