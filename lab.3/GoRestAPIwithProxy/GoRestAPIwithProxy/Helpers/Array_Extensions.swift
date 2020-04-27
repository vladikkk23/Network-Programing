//
//  Array_Extensions.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 17/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import UIKit

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
