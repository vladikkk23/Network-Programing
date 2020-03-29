//
//  ContentView.swift
//  GMail_MUI
//
//  Created by vladikkk on 28/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct ContentView: View {
        
    var emails: [EMail] = [EMail(sender: Sender(name: "Google", email: "google@gmail.com"), subject: "Created by vladikkk on 29/03/2020.Copyright © 2020 PR. All rights reserved.(1)", body: "SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them:, Created by vladikkk on 29/03/2020.Copyright © 2020 PR. All rights reserved.(1)SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them: SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them:, Created by vladikkk on 29/03/2020.Copyright © 2020 PR. All rights reserved.(1)SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them:  FIN ", date: "01/01/2020 11:11"), EMail(sender: Sender(name: "Google", email: "google@gmail.com"), subject: "Created by vladikkk on 29/03/2020.Copyright © 2020 PR. All rights reserved.(1)", body: "SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them:, Created by vladikkk on 29/03/2020.Copyright © 2020 PR. All rights reserved.(1)SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them: SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them:, Created by vladikkk on 29/03/2020.Copyright © 2020 PR. All rights reserved.(1)SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them:  FIN ", date: "01/01/2020 11:11"), EMail(sender: Sender(name: "Google", email: "google@gmail.com"), subject: "Created by vladikkk on 29/03/2020.Copyright © 2020 PR. All rights reserved.(1)", body: "SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them:, Created by vladikkk on 29/03/2020.Copyright © 2020 PR. All rights reserved.(1)SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them: SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them:, Created by vladikkk on 29/03/2020.Copyright © 2020 PR. All rights reserved.(1)SwiftUI’s Spacer views automatically fill up all available space on their axis of expansion, which is a fancy way of saying they take up as much space as they can either horizontally or vertically, depending on what you put them in.If you want to make a spacer of an exact size, just do the same thing you would do for any other kind of view: use a frame() modifier with the exact sizes you want.For example, this shows two text views, with a 50-point spacer in between them:  FIN ", date: "01/01/2020 11:11")]
    
    var body: some View {
        NavigationView {
            List(emails) { email in
                NavigationLink(destination: Email_DetailsView(email: email)) {
                    Email_Row(email: email)
                }
            }
            .navigationBarTitle("INBOX")
            .navigationBarItems(leading:
                Button(action: {
                    print("GET E-Mails Pressed.")
                }, label: {
                    Text("GET E-Mails")
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
