//
//  Verse.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 19/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Verse: Base {
    dynamic var number = 0
    dynamic var text = ""
    dynamic var hasTitle = false
    dynamic var title = ""
    dynamic var isSelected = false
    dynamic var isHighlighted = false
    dynamic var highlight: Highlight?
    
    let chapters = LinkingObjects(fromType: Chapter.self, property: "verses")
    
    var chapter: Chapter { chapters.first! }
    
    var book: Book { chapter.book }
    
    var bookNameChapterNumberVerseNumber: String {
        "\(chapter.book.bookName) \(chapter.chapterNumber) : \(number)"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["isSelected", "isHighlighted", "highlight"]
    }
    
    convenience required init(number: Int, text: String, hasTitle: Bool, title: String) {
        self.init()
        self.number = number
        self.text = text
        self.hasTitle = hasTitle
        self.title = title
    }
    
}
