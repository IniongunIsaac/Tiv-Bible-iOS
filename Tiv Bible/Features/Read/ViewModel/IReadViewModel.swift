//
//  IReadViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol IReadViewModel: Scopable {
    
    var currentSettings: Setting? { get set }
    
    var updateUIWithCurrentSettings: PublishSubject<Bool> { get }
    
    var bookNameAndChapterNumber: PublishSubject<String> { get }
    
    var currentVerses: PublishSubject<[Verse]> { get }
    
    var verseNumber: PublishSubject<Int> { get }
    
    var highlights: PublishSubject<[Highlight]> { get }
    
    var selectedVerses: [Verse] { get }
    
    var selectedVersesText: PublishSubject<String> { get }
    
    var shareableSelectedVersesText: String { get }
    
    var reloadVerses: PublishSubject<Bool> { get }
    
    var highlightColorsAndFontStyles: PublishSubject<(highlightColors: [HighlightColor], fontStyles: [FontStyle])> { get }
    
    var reloadFontStyles: PublishSubject<Bool> { get }
    
    var currentTheme: Theme { get set }
    
    func getBookFromSavedPreferencesOrInitializeWithGenese()
    
    func toggleSelectedVerse(verse: Verse)
    
    func getHighlightColorsAndFontStyles()
    
    func getUserSettings()
    
    func saveBookmarks()
    
    func saveNotes(_ notes: String)
    
    func setHighlightColorForSelectedVerses(_ color: HighlightColor)
    
    func increaseFontSize()
    
    func decreaseFontSize()
    
    func updateLineSpacing(type: LineSpacingType)
    
    func updateSelectedFontStyle(_ fontStyle: FontStyle)
    
}
