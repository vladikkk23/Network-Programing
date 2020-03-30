//
//  Create_EMailView.swift
//  GMail_MUI
//
//  Created by vladikkk on 29/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct Create_EMailView: View {
    @State var receivingEmail = ""
    @State var subject = ""
    @State var content = ""
    @State private var showingAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("To")
                            .font(.callout)
                            .bold()
                        TextField("Enter an email...", text: $receivingEmail)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Subject")
                            .font(.callout)
                            .bold()
                        TextField("Enter a subject...", text: $subject)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Body")
                            .font(.callout)
                            .bold()
                        
                        MultiLine_TextFieldView("Enter content...", text: $content)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding()
                }
            }
        }
        .navigationBarItems(trailing:
            Button(action: {
                if self.receivingEmail.isEmpty || self.subject.isEmpty || self.content.isEmpty {
                    self.showingAlert = true
                } else {
                    Send_Mail.shared.send(toEmail: self.receivingEmail, withSubject: self.subject, withBody: self.content)
                    
                    print("SENT")
                    
                    self.showingAlert = false
                    self.presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("SEND")
                    .foregroundColor(.green)
            })
                .alert(isPresented: self.$showingAlert) {
                    Alert(title: Text("WARNING!"), message: Text("Please complete all fields."), dismissButton: .cancel(Text("Got it!")))
        })
    }
}

struct Create_EMailView_Previews: PreviewProvider {
    static var previews: some View {
        Create_EMailView()
    }
}
