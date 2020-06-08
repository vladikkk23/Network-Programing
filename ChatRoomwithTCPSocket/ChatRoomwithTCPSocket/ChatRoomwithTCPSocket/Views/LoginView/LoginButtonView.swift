//
//  LoginButtonView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct LoginButtonView : View {
    var body: some View {
        VStack {
            Text("Join ChatRoom")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.blue)
                .cornerRadius(15.0)
        }
    }
}

struct LoginButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtonView()
    }
}
