//
//  ContentView.swift
//  GMail_MUI
//
//  Created by vladikkk on 28/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var inbox = Get_Inbox.shared
    
    var body: some View {
        NavigationView {
            List(inbox.emails) { email in
                NavigationLink(destination: Email_DetailsView(email: email)) {
                    Email_Row(email: email)
                }
            }
            .navigationBarTitle("INBOX")
            .navigationBarItems(leading:
                Button(action: {
                    self.inbox.updateInbox()
                }, label: {
                    Text("Update INBOX")
                        .foregroundColor(.red)
                })
                , trailing:
                NavigationLink(destination: Create_EMailView()) {
                    Text("SEND E-Mail")
                        .foregroundColor(.blue)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
