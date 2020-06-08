//
//  ProgressBarView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 21/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {
    @State var progress = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 16)
                .foregroundColor(Color.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 14.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.orange)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
            
        }.onAppear {
            self.loading()
        }
    }
    
    func loading() {
        Timer.scheduledTimer(withTimeInterval: 0.32, repeats: true) { timer in
            self.progress += 0.1
            if (self.progress >= 0.9) {
                timer.invalidate()
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
