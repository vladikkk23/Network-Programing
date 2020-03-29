//
//  Email_ListView.swift
//  GMail_MUI
//
//  Created by vladikkk on 29/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct Email_Row: View {

    var email: EMail

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(email.subject)
                    .bold()
            }
            
            Spacer()
            
            Text(email.date)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct Email_ListView_Previews: PreviewProvider {
    static var previews: some View {
        Email_Row(email: EMail(sender: Sender(name: "Google", email: "google@gmail.com"), subject: "Test_Subject", body: "Test_Body", date:"00:00"))
    }
}
