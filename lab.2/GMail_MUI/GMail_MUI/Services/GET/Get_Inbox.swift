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
    private var username = "el.zorro.show@gmail.com"
    private var password = "87897631rvsn5"
    
    // Singleton
    static let shared = Get_Inbox()
    
    // E-Mails
    @Published var emails = [EMail]()
    
    // Last Received E-Mail
    var lastEmail: EMail?
    
    // How many emails to download
    let count = 10
    
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
        
        self.fetchMails()
    }
    
    // MARK: Methods
    
    // Fetch all E-Mails.
    private func fetchMails()  {
        let folder = "INBOX"
        
        self.emails = [EMail]()
        
        for number in 0...self.count {
            let operation = imapSession.fetchMessageOperation(withFolder: folder, number: UInt32(number))
            
            operation?.start({ (error, data) in
                let messageParser = MCOMessageParser(data: data)
                
                let msgHTMLBody = messageParser?.htmlRendering(with: nil)
                
                guard let messageHTML = msgHTMLBody else { return }
                
                let contentExtractor = Content_Extractor(contentHTML: messageHTML)
                
                if number == 0 {
                    DispatchQueue.main.async {
                        self.lastEmail = contentExtractor.email
                    }
                } else if number == self.count {
                    DispatchQueue.main.async {
                        self.emails.insert(self.lastEmail!, at: 0)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.emails.insert(contentExtractor.email!, at: 0)
                    }
                }
            })
        }
    }
    
    // Check for new E-Mails.
    func updateInbox() {
        self.fetchMails()
    }
}
