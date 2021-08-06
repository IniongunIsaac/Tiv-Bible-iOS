//
//  LineSpacingType.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 06/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation

enum LineSpacingType {
    case small, normal, large
    
    var value: Int {
        switch self {
        case .small:
            return currentDevice.isPhone ? 8 : 9
        case .normal:
            return currentDevice.isPhone ? 9 : 10
        case .large:
            return currentDevice.isPhone ? 10 : 11
        }
    }
}
