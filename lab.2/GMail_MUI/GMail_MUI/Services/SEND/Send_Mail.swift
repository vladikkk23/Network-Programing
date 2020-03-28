//
//  Send_Mail.swift
//  GMail_MUI
//
//  Created by vladikkk on 28/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

/*
    A Singleton for sending a new E-Mail.
*/
class Send_Mail {
    
// MARK: Properties
    
    // Login Info
    private var hostname = "smtp.gmail.com"
    private var username = "Your Gmail Username"
    private var password = "Your Password"
    
    // Singleton
    static let shared = Send_Mail()
    
    // Session
    var smtpSession = MCOSMTPSession()
    
    // Configure Session Details
    private init() {
        smtpSession.hostname = self.hostname
        smtpSession.username = self.username
        smtpSession.password = self.password

        smtpSession.port = 587
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.startTLS
        smtpSession.isCheckCertificateEnabled = false
    }
    
// MARK: Methods

    // Send New Mail using SMTP-Session
    func send() {

        print(#function)

        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }

        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "zorro", mailbox: "el.zorro.show@gmail.com")!]
        builder.header.from = MCOAddress(displayName: "me", mailbox: "el.zorro.show@gmail.com")
        builder.header.subject = "TEST01"
        builder.htmlBody = "This is a test message!"

        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
}
