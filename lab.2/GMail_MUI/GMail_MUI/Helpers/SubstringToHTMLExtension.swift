//
//  SubstringToHTMLExtension.swift
//  GMail_MUI
//
//  Created by vladikkk on 30/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

/*
 A extension to transform a HTML Substring into a Plain-Text String.
 */
extension Substring {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
