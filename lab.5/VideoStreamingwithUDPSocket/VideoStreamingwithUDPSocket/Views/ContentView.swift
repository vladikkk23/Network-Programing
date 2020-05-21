//
//  ContentView.swift
//  VideoStreamingwithUDPSocket
//
//  Created by vladikkk on 21/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var message = ""
    
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack {
                    TextView(text: self.$message)
                        .frame(width: 350, height: 150)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray, lineWidth: 1) .padding(-2))
                        .padding()
                }
            }
            
            Button(action: {
                if self.message.isEmpty {
                    self.showingAlert = true
                } else {
                    StreamingService.shared.connect()
                    
                    StreamingService.shared.sendString(self.message)
                    self.message = ""
                }
            }) {
                Text("Send message")
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Warning"), message: Text("Please enter your message"), dismissButton: .default(Text("Dismiss")))
            }
        }
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator

        myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
