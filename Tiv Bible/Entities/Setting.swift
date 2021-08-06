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
    
    convenience required init(fontSize: Int, lineSpacing: Int, fontStyle: FontStyle, theme: Theme, stayAwake: Bool, audioSpeed: AudioSpeed) {
        self.init()
        self.fontSize = fontSize
        self.lineSpacing = lineSpacing
        self.fontStyle = fontStyle
        self.theme = theme
        self.stayAwake = stayAwake
        self.audioSpeed = audioSpeed
    }
    
    func newCopy(fontSize: Int? = nil, lineSpacing: Int? = nil, fontStyle: FontStyle? = nil, theme: Theme? = nil, stayAwake: Bool? = nil, audioSpeed: AudioSpeed? = nil) -> Setting {
        Setting().apply {
            $0.id = id
            $0.fontSize = fontSize ?? self.fontSize
            $0.lineSpacing = lineSpacing ?? self.lineSpacing
            $0.fontStyle = fontStyle ?? self.fontStyle
            $0.theme = theme ?? self.theme
            $0.stayAwake = stayAwake ?? self.stayAwake
            $0.audioSpeed = audioSpeed ?? self.audioSpeed
        }
    }
    
}
