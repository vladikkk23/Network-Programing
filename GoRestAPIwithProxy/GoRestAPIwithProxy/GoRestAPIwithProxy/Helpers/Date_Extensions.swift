//
//  Date_Extensions.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 07/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

extension Date {
    static func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
}
