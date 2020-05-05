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
        VStack {
            Text("Welcome to Animal Chat!")
            .font(Font(UIFont(name: "AvenirNext-DemiBold", size: 30)!))
            .padding(.bottom, 20)
            
            Text("Unleash your inner animal!")
                .font(Font(UIFont(name: "AvenirNext-DemiBold", size: 15)!))
                .padding(.bottom, 20)
                .foregroundColor(.gray)
        }
    }
}

struct WelcomeText_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTextView()
    }
}
