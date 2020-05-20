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
    let chapters = List<Chapter>()
    
    var bookName: String {
        return name.lowercased().capitalized
    }
    
    init(name: String, orderNo: Int, numberOfChapters: Int, numberOfVerses: Int, testament: Testament, version: Version) {
        super.init()
        self.name = name
        self.orderNo = orderNo
        self.numberOfChapters = numberOfChapters
        self.numberOfVerses = numberOfVerses
        self.testament = testament
        self.version = version
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
}
