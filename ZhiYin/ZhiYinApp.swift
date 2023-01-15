//
//  ZhiYinApp.swift
//  ZhiYin
//
//  Created by 王小劣 on 2023/1/9.
//  Collaborator: W-Mai

import SwiftUI

@main
struct ZhiYinApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

import AppKit
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem?
    
    @objc func exitApp() {
        NSApplication.shared.terminate(nil)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menuItem = NSMenuItem()
        menuItem.title = "退出"
        menuItem.target = self
        menuItem.action = #selector(exitApp)
        let menu = NSMenu()
        menu.addItem(menuItem)
        
        let contentView = ZYView()
        let mainView = NSHostingView(rootView: contentView)
        mainView.frame = NSRect(x: 0, y: 0, width: 22, height: 22)
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.menu = menu
        statusBarItem?.button?.title = " "
        statusBarItem?.button?.addSubview(mainView)
    }
}
