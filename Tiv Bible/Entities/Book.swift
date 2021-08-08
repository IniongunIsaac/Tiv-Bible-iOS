//
//  Book.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 19/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Book: BaseName {
    dynamic var orderNo = 0
    dynamic var numberOfChapters = 0
    dynamic var numberOfVerses = 0
    dynamic var testament: Testament?
    dynamic var version: Version?
    dynamic var isSelected = false
    let chapters = List<Chapter>()
    
    override static func ignoredProperties() -> [String] { ["isSelected"] }
    
    var bookName: String {
        return name.lowercased().capitalized
    }
    
    convenience required init(name: String, orderNo: Int, numberOfChapters: Int, numberOfVerses: Int, testament: Testament, version: Version) {
        self.init()
        self.name = name
        self.orderNo = orderNo
        self.numberOfChapters = numberOfChapters
        self.numberOfVerses = numberOfVerses
        self.testament = testament
        self.version = version
    }
    
}
