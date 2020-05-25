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
    
    convenience required init(hexCode: String) {
        self.init()
        self.hexCode = hexCode
    }

}
