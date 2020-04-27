//
//  ContentView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 02/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showSplash = true
    
    var body: some View {
        ZStack {
            AlbumListView()
                .frame(width: 410, height: 850, alignment: .center)
            
            SplashView()
                .opacity(showSplash ? 1 : 0)
                .onAppear {
                    self.showSplashScreen(time: 4)
            }
        }
    }
    
    private func showSplashScreen(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
            self.showSplash = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
