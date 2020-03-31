//
//  Get_Inbox.swift
//  GMail_MUI
//
//  Created by vladikkk on 28/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

/*
 A Singleton for extracting Inbox E-Mails.
 */
class Get_Inbox: ObservableObject {
    
    // MARK: Properties
    
    // Login Info
    private var hostname = "imap.gmail.com"
    private var username = "YOUR USERNAME"
    private var password = "YOUR PASSWORD"
    
    // Singleton
    static let shared = Get_Inbox()
    
    // Published E-Mails
    @Published var emails = [EMail]()
    
    // Last Received E-Mail
    var lastEmail: EMail?
    
    // How many emails to download
    var count = 10
    
    // Session
    var imapSession: MCOIMAPSession = MCOIMAPSession()
    
    // Configure Session Details && Start Fetching E-Mails
    private init() {
        imapSession.hostname = self.hostname
        imapSession.username = self.username
        imapSession.password = self.password
        
        imapSession.port = 993
        imapSession.authType = MCOAuthType.saslPlain
        imapSession.connectionType = MCOConnectionType.TLS
        imapSession.isCheckCertificateEnabled = false
        
        self.fetchMails(count: self.count)
    }
    
    // MARK: Methods
    
    // Fetch all E-Mails.
    private func fetchMails(count: Int)  {
        let folder = "INBOX"
        
        var EMails = [EMail]()
        
        for number in 0...self.count {
            
            // Define IMAP-Fetch Operation
            let operation = imapSession.fetchMessageOperation(withFolder: folder, number: UInt32(number))
            
            // Start IMAP-Fetch Operation
            operation?.start({ (error, data) in
                let messageParser = MCOMessageParser(data: data)
                
                let msgHTMLBody = messageParser?.htmlRendering(with: nil)
                
                guard let messageHTML = msgHTMLBody else { return }
                
                let contentExtractor = Content_Extractor(contentHTML: messageHTML)
                
                if number == 0 && count > 1 {
                    
                    guard let emailToInsert = contentExtractor.email else { return }
                    
                    self.lastEmail = emailToInsert
                } else {
                    if number == count && count > 1 {
                        DispatchQueue.main.async {
                            print("########## UI Thread -- NUMBER: \(number)##########")
                            
                            EMails.insert(self.lastEmail!, at: 0)
                            self.emails = EMails
                        }
                    } else if number == count && count == 1 {
                        DispatchQueue.main.async {
                            print("########## UI Thread -- NUMBER: \(number)##########")
                            
                            var temp = self.emails.reversed() as [EMail]
                            temp.append(contentsOf: EMails.reversed())
                            
                            DispatchQueue.main.async {
                                self.emails = temp.reversed() as [EMail]
                            }
                        }
                    } else {
                        print("~~~~~~~~~~MESSAGE \(number)~~~~~~~~~~")
                        
                        guard let emailToInsert = contentExtractor.email else { return }
                        
                        EMails.insert(emailToInsert, at: 0)
                    }
                }
            })
        }
    }
    
    // Update INBOX with new E-Mails.
    func updateInbox() {
        if self.emails.isEmpty {
            self.fetchMails(count: self.count)
        } else {
            self.fetchMails(count: 1)
        }
    }
}
