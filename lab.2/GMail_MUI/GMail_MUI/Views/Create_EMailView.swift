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
                print("SENT")
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("SEND")
                    .foregroundColor(.green)
            }))
    }
}

struct Create_EMailView_Previews: PreviewProvider {
    static var previews: some View {
        Create_EMailView()
    }
}
