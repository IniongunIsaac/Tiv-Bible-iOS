//
//  HighlightColor.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

@objcMembers class HighlightColor: Base {
    dynamic var hexCode = ""
    
    init(hexCode: String) {
        self.hexCode = hexCode
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
