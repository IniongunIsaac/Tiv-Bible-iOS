//
//  Setting.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

@objcMembers class Setting: Base {
    dynamic var fontSize = 0
    dynamic var lineSpacing = 0
    dynamic var fontStyle: FontStyle?
    dynamic var theme: Theme?
    dynamic var stayAwake = false
    dynamic var audioSpeed: AudioSpeed?
    
    init(fontSize: Int, lineSpacing: Int, fontStyle: FontStyle, theme: Theme, stayAwake: Bool, audioSpeed: AudioSpeed) {
        self.fontSize = fontSize
        self.lineSpacing = lineSpacing
        self.fontStyle = fontStyle
        self.theme = theme
        self.stayAwake = stayAwake
        self.audioSpeed = audioSpeed
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
