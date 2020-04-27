//
//  ExtractMail_Contents.swift
//  GMail_MUI
//
//  Created by vladikkk on 30/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

/*
 A class to extract E-Mail's content as Plain Text.
 */

class Content_Extractor {
    
    // MARK: Properties
    
    // E-Mail content as HTML
    var contentHTML: String
    
    // E-Mail content as Plain Text
    var email: EMail?
    
    init(contentHTML: String) {
        self.contentHTML = contentHTML
        
        self.email = getEmailAsPlainText()
    }
    
    private func extractSenderNameAsText() -> Substring {
        let leftTag = """
        From:</b>
        """
        let rightTag = """
        &lt;
        """
        
        guard let leftRange = self.contentHTML.range(of: leftTag) else { return "LEFT RANGE ERROR" }
        guard let rightRange = self.contentHTML.range(of: rightTag) else { return "RIGHT RANGE ERROR" }
        
        let valueRange = leftRange.upperBound..<rightRange.lowerBound
        
        return self.contentHTML[valueRange]
    }
    
    private func extractSenderEmailAsText() -> Substring {
        let leftTag = """
        &lt;
        """
        let rightTag = """
        &gt;
        """
        
        guard let leftRange = self.contentHTML.range(of: leftTag) else { return "LEFT RANGE ERROR" }
        guard let rightRange = self.contentHTML.range(of: rightTag) else { return "RIGHT RANGE ERROR" }
        
        let valueRange = leftRange.upperBound..<rightRange.lowerBound
        
        return self.contentHTML[valueRange]
    }
    
    private func extractDateAsText() -> Substring {
        let leftTag = """
        Date:</b>
        """
        let rightTag = """
        </div>                 </div>
        """
        
        guard let leftRange = self.contentHTML.range(of: leftTag) else { return "LEFT RANGE ERROR" }
        guard let rightRange = self.contentHTML.range(of: rightTag) else { return "RIGHT RANGE ERROR" }
        
        let valueRange = leftRange.upperBound..<rightRange.lowerBound
        
        return self.contentHTML[valueRange]
    }
    
    private func extractSubjectAsText() -> Substring {
        let leftTag = """
        Subject:</b>
        """
        let rightTag = """
        </div>                                                   <div><b>D
        """
        
        guard let leftRange = self.contentHTML.range(of: leftTag) else { return "LEFT RANGE ERROR" }
        guard let rightRange = self.contentHTML.range(of: rightTag) else { return "RIGHT RANGE ERROR" }
        
        let valueRange = leftRange.upperBound..<rightRange.lowerBound
        
        return self.contentHTML[valueRange]
    }
    
    private func extractBodyAsText() -> String {
        let leftTag = """
        </head>
        """
        let rightTag = """
        </body>
        """
        
        guard let leftRange = self.contentHTML.range(of: leftTag) else { return "LEFT RANGE ERROR" }
        guard let rightRange = self.contentHTML.range(of: rightTag) else { return "RIGHT RANGE ERROR" }
        
        let valueRange = leftRange.upperBound..<rightRange.lowerBound
        
        return self.contentHTML[valueRange].htmlToString
    }
    
    // Check E-Mail contents
    private func checkEmailIntegrity(ofEmail email: EMail) -> Bool {
        
        if email.sender.name == "LEFT RANGE ERROR" || email.sender.email == "LEFT RANGE ERROR" || email.date == "LEFT RANGE ERROR", email.subject == "LEFT RANGE ERROR" || email.body == "LEFT RANGE ERROR" {
            return false
        }
        
        if email.sender.name == "RIGHT RANGE ERROR" || email.sender.email == "RIGHT RANGE ERROR" || email.date == "RIGHT RANGE ERROR", email.subject == "RIGHT RANGE ERROR" || email.body == "RIGHT RANGE ERROR" {
            return false
        }
        
        return true
    }
    
    // Perform a check of the E-Mail and return it if it's ok
    private func getEmailAsPlainText() -> EMail? {
        let senderName = self.extractSenderNameAsText()
        let senderEmail = self.extractSenderEmailAsText()
        let date = self.extractDateAsText()
        let subject = self.extractSubjectAsText()
        let body = self.extractBodyAsText()
        
        let sender = Sender(name: senderName.description, email: senderEmail.description)
        let email = EMail(sender: sender, date: date.description, subject: subject.description, body: body)
        
        let goodEmail = self.checkEmailIntegrity(ofEmail: email)
        
        print(#function + " --> \(goodEmail)")
        
        return goodEmail ? email : nil
    }
}
