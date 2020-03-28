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
class Get_Inbox {
    
// MARK: Properties
    
    // Login Info
    private var hostname = "imap.gmail.com"
    private var username = "Your Gmail Username"
    private var password = "Your Password"
    
    // Singleton
    static let shared = Get_Inbox()
    
    // Session
    var imapSession: MCOIMAPSession = MCOIMAPSession()
    
    // Configure Session Details
    private init() {
        imapSession.hostname = self.hostname
        imapSession.username = self.username
        imapSession.password = self.password
        
        imapSession.port = 993
        imapSession.authType = MCOAuthType.saslPlain
        imapSession.connectionType = MCOConnectionType.TLS
        imapSession.isCheckCertificateEnabled = false
    }
    
// MARK: Methods
    
    func fetchMails()  {
        
        let requestKind: MCOIMAPMessagesRequestKind = .headers
        let folder = "INBOX"
        let uids = MCOIndexSet(range: MCORangeMake(1, UINT64_MAX))
        
        let fetchOperation = imapSession.fetchMessagesOperation(withFolder: folder, requestKind: requestKind, uids: uids)
        
        fetchOperation?.start({ error, fetchedMessages, vanishedMessages in
            //Check for an error:
            if error != nil {
                if let error = error {
                    print("Error downloading message headers:\(error)")
                }
            }
            
            //Print E-Mails
            if let fetchedMessages = fetchedMessages {
                print("The post man delivereth:\(fetchedMessages)")
            }
        })
    }
}
