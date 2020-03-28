//
//  ContentView.swift
//  GMail_MUI
//
//  Created by vladikkk on 28/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var didTapGet: Bool = false
    @State private var didTapSend: Bool = false

    var body: some View {
        VStack {
            Button(action: {
                self.didTapGet.toggle()
                
                Get_Inbox.shared.fetchMails()
            }) {
                Text("Load E-Mails")
                    .foregroundColor(didTapGet ? Color.green : Color.red)
            }
            
            Spacer()
                .lineSpacing(CGFloat(exactly: 10)!)
            
            Button(action: {
                self.didTapSend.toggle()
                
                Send_Mail.shared.send()
            }) {
                Text("Send E-Mail")
                    .foregroundColor(didTapSend ? Color.green : Color.blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
