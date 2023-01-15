//
//  ZYView.swift
//  ZhiYin
//
//  Created by 王小劣 on 2023/1/10.
//  Collaborator: W-Mai
//

import SwiftUI

struct ZYView: View {
    @Environment(\.colorScheme) var currentMode
    @StateObject var cpuInfo = CpuUsage()
    
    // TODO: 未来增加设置，控制这些值
    @AppStorage("AutoReverse") private var autoReverse = true
    @State var imageSetName = "zhiyin"
    @State var imageName = ""
    @State var imageNum = 17
    
    @State var direction = 1
    @State var imageIndex = 0
    
    var body: some View {
        let timer = Timer.publish(every: TimeInterval((1 - cpuInfo.cuse) / 10), on: .main, in: .common).autoconnect()
        VStack {
            VStack {
                if currentMode == .dark {
                    Image(imageName).resizable().colorInvert()
                } else {
                    Image(imageName).resizable()
                }
            }
            .frame(width: 22, height: 22)
            .onReceive(timer) { _ in
                if imageIndex == 0 {
                    direction = 1
                }
                if imageIndex == imageNum - 1 {
                    if autoReverse {
                        direction = -1
                    } else {
                        direction = 1
                        imageIndex = 0
                    }
                }
                
                imageIndex += direction
                imageName = "\(imageSetName)\(imageIndex)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZYView()
    }
}
