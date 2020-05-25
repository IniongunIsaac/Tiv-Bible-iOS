//
//  Other.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

@objcMembers class Other: Base {
    dynamic var title = ""
    dynamic var subTitle = ""
    dynamic var text = ""
    
    convenience required init(title: String, subTitle: String, text: String) {
        self.init()
        self.title = title
        self.subTitle = subTitle
        self.text = text
    }

}
