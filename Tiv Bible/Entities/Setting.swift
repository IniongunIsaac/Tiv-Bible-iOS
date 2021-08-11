//
//  Setting.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit

@objcMembers class Setting: Base {
    dynamic var fontSize = 0
    dynamic var lineSpacing = 0
    dynamic var fontStyle: FontStyle?
    dynamic var stayAwake = false
    dynamic var audioSpeed: AudioSpeed?
    
    convenience required init(fontSize: Int, lineSpacing: Int, fontStyle: FontStyle, stayAwake: Bool, audioSpeed: AudioSpeed) {
        self.init()
        self.fontSize = fontSize
        self.lineSpacing = lineSpacing
        self.fontStyle = fontStyle
        self.stayAwake = stayAwake
        self.audioSpeed = audioSpeed
    }
    
    func newCopy(fontSize: Int? = nil, lineSpacing: Int? = nil, fontStyle: FontStyle? = nil, stayAwake: Bool? = nil, audioSpeed: AudioSpeed? = nil) -> Setting {
        Setting().apply {
            $0.id = id
            $0.fontSize = fontSize ?? self.fontSize
            $0.lineSpacing = lineSpacing ?? self.lineSpacing
            $0.fontStyle = fontStyle ?? self.fontStyle
            $0.stayAwake = stayAwake ?? self.stayAwake
            $0.audioSpeed = audioSpeed ?? self.audioSpeed
        }
    }
    
    var lineSpacingType: LineSpacingType {
        if (currentDevice.isPhone && lineSpacing == 8) || (currentDevice.isPad && lineSpacing == 9) {
            return .small
        } else if (currentDevice.isPhone && lineSpacing == 9) || (currentDevice.isPad && lineSpacing == 10) {
            return .normal
        } else {
            return .large
        }
    }
    
}
