//
//  EMail.swift
//  GMail_MUI
//
//  Created by vladikkk on 28/03/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

/*
   Email Form Model.
 */
struct EMail: Identifiable {
    var id = UUID()
    
    var sender: Sender
    var date: String
    var subject: String
    var body: String
}
