//
//  MoreViewModelImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

class MoreViewModelImpl: BaseViewModel, IMoreViewModel {
    
    var bookmarks: PublishSubject<[Bookmark]> = PublishSubject()
    var showReaderView: PublishSubject<Bool> = PublishSubject()
    var highlights: PublishSubject<[Highlight]> = PublishSubject()
    var notes: PublishSubject<[Note]> = PublishSubject()
    var history: PublishSubject<[History]> = PublishSubject()
    var currentSettings: Setting? = nil
    var fontStyles: PublishSubject<[FontStyle]> = PublishSubject()
    var updateUIWithCurrentSettings: PublishSubject<Bool> = PublishSubject()
    
    fileprivate let bookmarksRepo: IBookmarkRepo
    fileprivate let notesRepo: INoteRepo
    fileprivate let highlightsRepo: IHighlightRepo
    fileprivate let historyRepo: IHistoryRepo
    fileprivate let settingsRepo: ISettingRepo
    fileprivate let othersRepo: IOtherRepo
    fileprivate var preferenceRepo: IPreferenceRepo
    fileprivate let fontStylesRepo: IFontStyleRepo
    
    init(bookmarksRepo: IBookmarkRepo, notesRepo: INoteRepo, highlightsRepo: IHighlightRepo, historyRepo: IHistoryRepo, settingsRepo: ISettingRepo, othersRepo: IOtherRepo, preferenceRepo: IPreferenceRepo, fontStylesRepo: IFontStyleRepo) {
        self.bookmarksRepo = bookmarksRepo
        self.notesRepo = notesRepo
        self.highlightsRepo = highlightsRepo
        self.historyRepo = historyRepo
        self.settingsRepo = settingsRepo
        self.othersRepo = othersRepo
        self.preferenceRepo = preferenceRepo
        self.fontStylesRepo = fontStylesRepo
    }
    
    var currentTheme: Theme {
        get { preferenceRepo.currentTheme }
        set {
            preferenceRepo.currentTheme = newValue
            runAfter(0.2) { [weak self] in
                self?.updateUIWithCurrentSettings.onNext(true)
            }
        }
    }
    
    var stayAwake: Bool {
        get { preferenceRepo.stayAwake }
        set {
            preferenceRepo.stayAwake = newValue
            keepDeviceAwake(newValue)
        }
    }
    
    func getBookmarks() {
        subscribe(bookmarksRepo.getBookmarks(), success: { [weak self] bookmarks in
            self?.bookmarks.onNext(bookmarks)
        })
    }
    
    func deleteBookmark(_ bookmark: Bookmark) {
        subscribe(bookmarksRepo.deleteBookmarks(bookmarks: [bookmark]), success: { [weak self] in
            self?.getBookmarks()
        })
    }
    
    func deleteAllBookmarks() {
        subscribe(bookmarksRepo.deleteAllBookmarks(), success: { [weak self] in
            self?.getBookmarks()
        })
    }
    
    func readFullChapter(bookId: String, chapterId: String, verseId: String, verseNumber: Int) {
        preferenceRepo.currentBookId = bookId
        preferenceRepo.currentChapterId = chapterId
        preferenceRepo.currentVerseId = verseId
        preferenceRepo.selectedVerseNumber = verseNumber
        preferenceRepo.shouldScrollToVerse = true
        updateReloadVersesPreference()
        showReaderView.onNext(true)
    }
    
    func getHighlights() {
        subscribe(highlightsRepo.getAllHighlights(), success: { [weak self] highlights in
            self?.highlights.onNext(highlights)
        })
    }
    
    func deleteHighlight(_ highlight: Highlight) {
        subscribe(highlightsRepo.deleteHighlights(highlights: [highlight]), success: { [weak self] in
            self?.updateReloadVersesPreference()
            self?.getHighlights()
        })
    }
    
    func deleteAllHighlights() {
        subscribe(highlightsRepo.deleteAllHighlights(), success: { [weak self] in
            self?.updateReloadVersesPreference()
            self?.getHighlights()
        })
    }
    
    func getNotes() {
        subscribe(notesRepo.getNotes(), success: { [weak self] notes in
            self?.notes.onNext(notes)
        })
    }
    
    func deleteNote(_ note: Note) {
        subscribe(notesRepo.deleteNotes(notes: [note]), success: { [weak self] in
            self?.getNotes()
        })
    }
    
    func deleteAllNotes() {
        subscribe(notesRepo.deleteAllNotes(), success: { [weak self] in
            self?.getNotes()
        })
    }
    
    func getHistory() {
        
    }
    
    func deleteHistory(_ history: History) {
        
    }
    
    func deleteAllHistory() {
        
    }
    
    fileprivate func updateReloadVersesPreference(reload: Bool = true) {
        preferenceRepo.shouldReloadVerses = reload
    }
    
    func getFontStyles() {
        subscribe(fontStylesRepo.getAllFontStyles(), viewControllerType: .bottomSheet, success: { [weak self] styles in
            self?.fontStyles.onNext(styles)
        })
    }
    
    func increaseFontSize() {
        guard let currentSettings = currentSettings else { return }
        if currentSettings.fontSize == AppConstants.maxFontSize {
            showMessage("Maximum font size for your device is \(AppConstants.maxFontSize)px", type: .error, viewControllerType: .bottomSheet)
        } else {
            let fontSize = currentSettings.fontSize + 1
            updateUserSettings(currentSettings.newCopy(fontSize: fontSize))
        }
    }
    
    func decreaseFontSize() {
        guard let currentSettings = currentSettings else { return }
        if currentSettings.fontSize == AppConstants.minFontSize {
            showMessage("Minimum font size for your device is \(AppConstants.minFontSize)px", type: .error, viewControllerType: .bottomSheet)
        } else {
            let fontSize = currentSettings.fontSize - 1
            updateUserSettings(currentSettings.newCopy(fontSize: fontSize))
        }
    }
    
    func getUserSettings() {
        subscribe(settingsRepo.getAllSetting(), viewControllerType: .bottomSheet, success: { [weak self] setting in
            self?.currentSettings = setting
            self?.updateUIWithCurrentSettings.onNext(true)
        })
    }
    
    fileprivate func updateUserSettings(_ settings: Setting) {
        subscribe(settingsRepo.updateSettings(setting: settings), viewControllerType: .bottomSheet, success: { [weak self] in
            self?.getUserSettings()
        })
    }
    
    func updateLineSpacing(type: LineSpacingType) {
        updateUserSettings(currentSettings!.newCopy(lineSpacing: type.value))
    }
    
    func updateSelectedFontStyle(_ fontStyle: FontStyle) {
        updateUserSettings(currentSettings!.newCopy(fontStyle: fontStyle))
    }
    
}
