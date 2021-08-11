//
//  IMoreViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol IMoreViewModel: Scopable {
    
    var bookmarks: PublishSubject<[Bookmark]> { get set }
    
    var showReaderView: PublishSubject<Bool> { get }
    
    var highlights: PublishSubject<[Highlight]> { get set }
    
    var notes: PublishSubject<[Note]> { get set }
    
    var history: PublishSubject<[History]> { get set }
    
    var currentSettings: Setting? { get set }
    
    var updateUIWithCurrentSettings: PublishSubject<Bool> { get }
    
    var fontStyles: PublishSubject<[FontStyle]> { get }
    
    var currentTheme: Theme { get set }
    
    func getBookmarks()
    
    func deleteBookmark(_ bookmark: Bookmark)
    
    func deleteAllBookmarks()
    
    func readFullChapter(bookId: String, chapterId: String, verseId: String, verseNumber: Int)
    
    func getHighlights()
    
    func deleteHighlight(_ highlight: Highlight)
    
    func deleteAllHighlights()
    
    func getNotes()
    
    func deleteNote(_ note: Note)
    
    func deleteAllNotes()
    
    func getHistory()
    
    func deleteHistory(_ history: History)
    
    func deleteAllHistory()
    
    func getFontStyles()
    
    func getUserSettings()
    
    func increaseFontSize()
    
    func decreaseFontSize()
    
    func updateLineSpacing(type: LineSpacingType)
    
    func updateSelectedFontStyle(_ fontStyle: FontStyle)
    
}
