//
//  RecentSearch.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class RecentSearch: Object {
    dynamic var text = ""
    
    override static func primaryKey() -> String? {
        return "text"
    }
}
