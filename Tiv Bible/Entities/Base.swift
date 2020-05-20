//
//  Base.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 19/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Base: Object {
    dynamic var id = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
