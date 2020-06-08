//
//  SplashView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 18/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI
import UIKit

struct SplashView: View {    
    var body: some View {
        ZStack {
            Image("splash")
                .clipped()
                .aspectRatio(contentMode: .fill)
            Image("goRestLogo")
                .clipped()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
