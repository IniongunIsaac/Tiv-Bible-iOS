//
//  Highlight.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 20/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Highlight: Object {
    dynamic var highlightedOn = Date()
    dynamic var color: HighlightColor?
    dynamic var book: Book?
    dynamic var chapter: Chapter?
    dynamic var verse: Verse?
    dynamic var compositePrimaryKey = ""

    override static func primaryKey() -> String? {
        return "compositePrimaryKey"
    }
    
    var bookNameAndChapterNumberAndVerseNumberString: String { "\(book!.name) \(chapter!.chapterNumber):\(verse!.number)" }
    
    var dateString: String { highlightedOn.dateOnly(format: "dd.MM.yyyy") }
    
    var shareableText: String { "\(bookNameAndChapterNumberAndVerseNumberString)\n\(verse!.text)" }
    
    convenience required init(book: Book, chapter: Chapter, verse: Verse, color: HighlightColor) {
        self.init()
        self.book = book
        self.chapter = chapter
        self.verse = verse
        self.color = color
        compositePrimaryKey = "\(self.book!.id)_\(self.chapter!.id)_\(self.verse!.number)"
    }
    
}
