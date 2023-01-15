//
//  ZhiYinApp.swift
//  ZhiYin
//
//  Created by 王小劣 on 2023/1/9.
//  Collaborator: W-Mai

import SwiftUI

struct ImageSetInfo: Identifiable {
    var id:   Int
    var name: String
    var num:  Int
    var desp: String
}

// TODO: 动态加载
var imageSet = [
    ImageSetInfo(id: 0, name: "zhiyin", num: 17, desp: "只因铁山靠⛰️"),
    ImageSetInfo(id: 1, name: "zhiyinbas", num: 17, desp: "只因篮球🏀")
]

@main
struct ZhiYinApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("AutoReverse") private var autoReverse = true
    @AppStorage("CurrentImageSet") private var currentImageSet = 0
    @AppStorage("ThemeMode") private var themeMode = 0
    
    var body: some Scene {
        Settings {
            TabView {
                Form {
                    List {
                        HStack(alignment: .center) {
                            ZYView(width: 100, height: 100)
                        }.padding(20)
                            .frame(maxWidth: .infinity)
                        
                        Picker(selection: $themeMode, label: Text("主题")) {
                            Text("明亮").tag(0)
                            Text("暗黑").tag(1)
                            Text("跟随系统").tag(2)
                        }
                        Toggle("自动反转播放", isOn: $autoReverse).toggleStyle(.switch)
                        HStack {
                            Picker(selection: $currentImageSet, label: Text("图集")) {
                                ForEach(imageSet) {item in
                                    Text(item.desp).tag(item.id)
                                }
                            }
                        }.frame(width: 200)
                    }
                }
                .frame(width: 300, height: 300)
                .tabItem {Label("通用", systemImage: "gear")}
                
                Form {
                    VStack {
                        Text("🐔🫵🏻🌞🈚️")
                            .font(.system(size: 100)).multilineTextAlignment(.center)
                    }.onTapGesture {
                        NSWorkspace.shared.open(URL(string:"https://github.com/Eilgnaw/ZhiYin")!)
                    }
                    
                }.frame(width: 300, height: 300)
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
            NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
        } else {
            NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        }
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let menuItem = NSMenuItem()
        menuItem.title = "退出"
        menuItem.target = self
        menuItem.action = #selector(exitApp)
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "设置", action: #selector(openSettings), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "退出", action: #selector(exitApp), keyEquivalent: ""))
        
        let contentView = ZYView(width: 22, height: 22)
        let mainView = NSHostingView(rootView: contentView)
        mainView.frame = NSRect(x: 0, y: 0, width: 22, height: 22)
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.menu = menu
        statusBarItem?.button?.title = " "
        statusBarItem?.button?.addSubview(mainView)
        statusBarItem?.button?.action = #selector(exitApp)
    }
}
