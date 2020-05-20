//
//  BaseName.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 19/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

@objcMembers class BaseName: Base {
    dynamic var name = ""
    
    init(name: String) {
        self.name = name
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
