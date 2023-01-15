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
    
    @AppStorage("AutoReverse") private var autoReverse = true
    
    var body: some Scene {
        Settings {
            TabView {
                VStack{
                    Toggle("自动反转", isOn: $autoReverse).toggleStyle(.switch)
                }.frame(width: 300, height: 400)
                    .tabItem {Label("通用", systemImage: "gear")}
                VStack{
                    Text("🐔你太美！")
                }.frame(width: 300, height: 600)
                    .tabItem {Label("关于", systemImage: "info.circle.fill")}
            }
        }
    }
}

import AppKit
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem?
    
    @objc func exitApp() {
        NSApplication.shared.terminate(nil)
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
    }
    
    @objc func openSettings() {
        if #available(macOS 13, *) {
            print( NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil))
            NSApplication.shared.activate(ignoringOtherApps: true)
        } else {
            print(
                NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
            )
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menuItem = NSMenuItem()
        menuItem.title = "退出"
        menuItem.target = self
        menuItem.action = #selector(exitApp)
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "设置", action: #selector(openSettings), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "退出", action: #selector(exitApp), keyEquivalent: ""))
        
        let contentView = ZYView()
        let mainView = NSHostingView(rootView: contentView)
        mainView.frame = NSRect(x: 0, y: 0, width: 22, height: 22)
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.menu = menu
        statusBarItem?.button?.title = " "
        statusBarItem?.button?.addSubview(mainView)
        statusBarItem?.button?.action = #selector(exitApp)
    }
}
