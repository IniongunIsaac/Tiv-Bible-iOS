//
//  Bookmark.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 19/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Bookmark: Object {
    dynamic var bookmarkedOn = Date()
    dynamic var book: Book?
    dynamic var chapter: Chapter?
    dynamic var verse: Verse?
    dynamic var compositePrimaryKey = ""

    override static func primaryKey() -> String? {
        return "compositePrimaryKey"
    }
    
    var bookNameAndChapterNumberAndVerseNumberString: String {
        return "\(book!.name) \(chapter!.chapterNumber) \(verse!.number)"
    }
    
    var dateString: String {
        return bookmarkedOn.dateOnly(format: "dd.MM.yyyy")
    }
    
    init(book: Book, chapter: Chapter, verse: Verse) {
        self.book = book
        self.chapter = chapter
        self.verse = verse
        compositePrimaryKey = "\(self.book!.id)_\(self.chapter!.id)_\(self.verse!.number)"
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
