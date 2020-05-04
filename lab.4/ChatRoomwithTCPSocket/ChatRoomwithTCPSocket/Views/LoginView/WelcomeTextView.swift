//
//  WelcomeText.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct WelcomeTextView : View {
    var body: some View {
        Text("Welcome to Animal Chat!")
            .font(Font(UIFont(name: "AvenirNext-DemiBold", size: 30)!))
            .padding(.bottom, 20)
    }
}

struct WelcomeText_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTextView()
    }
}
