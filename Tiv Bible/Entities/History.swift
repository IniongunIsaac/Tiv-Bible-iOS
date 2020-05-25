//
//  History.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class History: Object {
    dynamic var historyDate = Date()
    dynamic var book: Book?
    dynamic var chapter: Chapter?
    dynamic var compositePrimaryKey = ""

    override static func primaryKey() -> String? {
        return "compositePrimaryKey"
    }
    
    var bookNameAndChapterNumber: String {
        return "\(book!.bookName) \(chapter!.chapterNumber)"
    }
    
    var dateString: String {
        return historyDate.dateOnly(format: "dd.MM.yyyy")
    }
    
    convenience required init(book: Book, chapter: Chapter) {
        self.init()
        self.book = book
        self.chapter = chapter
        compositePrimaryKey = "\(self.chapter!.id)"
    }
    
}
