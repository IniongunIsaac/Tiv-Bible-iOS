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
    
    var currentSettings: PublishSubject<Setting> { get }
    
    var bookNameAndChapterNumber: PublishSubject<String> { get }
    
    var currentVerses: PublishSubject<[Verse]> { get }
    
    var verseNumber: PublishSubject<Int> { get }
    
    var highlights: PublishSubject<[Highlight]> { get }
    
    var selectedVerses: [Verse] { get }
    
    var selectedVersesText: PublishSubject<String> { get }
    
    var shareableSelectedVersesText: String { get }
    
    var verseSelected: PublishSubject<Bool> { get }
    
    var highlightColorsFontStylesAndThemes: PublishSubject<(highlightColors: [HighlightColor], fontStyles: [FontStyle], themes: [Theme])> { get }
    
    func getBookFromSavedPreferencesOrInitializeWithGenese()
    
    func toggleSelectedVerse(verse: Verse)
    
    func getHighlightColorsFontStylesAndThemes()
    
    func getUserSettings()
    
    func saveBookmarks()
    
    func saveNotes(_ notes: String)
    
}
