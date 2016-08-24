//
//  Copyright 2016 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit

public extension QuickTableViewRow where Self: RawRepresentable, Self.RawValue == Int {
    init(at indexPath: NSIndexPath) {
        self.init(indexPath.row)
    }

    init(_ row: Int) {
        self.init(rawValue: row)!
    }

    static var count: Int {
        return lastRow.rawValue + 1
    }
}

public extension QuickTableViewRowWithConditions where Self: RawRepresentable, Self.RawValue == Int {
    init(row: Int, container: Container) {
        var row = row
        let _conditionalRows = Self.conditionalRows(container)
        for (conditionalRow, test) in _conditionalRows {
            if row >= conditionalRow.rawValue && !test {
                row += 1
            }
        }
        self.init(rawValue: row)!
    }

    static func count(container container: Container) -> Int {
        var count = lastRow.rawValue + 1
        let _conditionalRows = conditionalRows(container)
        for (_, test) in _conditionalRows {
            if !test {
                count -= 1
            }
        }
        return count
    }
}