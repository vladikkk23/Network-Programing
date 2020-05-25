//
//  ContentView.swift
//  VideoStreamingwithUDPSocket
//
//  Created by vladikkk on 21/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var isShowingCamera = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CameraView(), isActive: self.$isShowingCamera) {
                    EmptyView()
                }
                
                Button(action: {
                    self.isShowingCamera = true
                }) {
                    Text("Start video stream")
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear {
                StreamingService.shared.connect()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
