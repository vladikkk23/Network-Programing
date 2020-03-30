//
//  Email_DetailsView.swift
//  GMail_MUI
//
//  Created by vladikkk on 29/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct Email_DetailsView: View {
    
    var email: EMail
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(email.subject)
                        .font(.title)
                        .bold()
                    
                    Divider()

                    HStack {
                        Text("From: \(email.sender.name)")
                            .font(.headline)
                            .bold()
                        
                        Spacer()
                        
                        Text("< \(email.sender.email) >")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Sent on: ")
                            .font(.headline)
                            .bold()
                        
                        Spacer()
                        
                        Text(email.date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Divider()
                
                Text(email.body)
                    .font(.body)
            }
            .padding(.horizontal)
        }
    }
}

struct Email_DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Email_DetailsView(email: EMail(sender: Sender(name: "Google", email: "google@gmail.com"), date: "01/01/2001 00:00", subject: "TEST SUBJECT", body: "TEST BODY"))
    }
}
