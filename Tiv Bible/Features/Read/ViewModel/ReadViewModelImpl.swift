//
//  ReadViewModelImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

class ReadViewModelImpl: BaseViewModel, IReadViewModel {
    
    let bookRepo: IBookRepo
    let verseRepo: IVerseRepo
    let chapterRepo: IChapterRepo
    var preferenceRepo: IPreferenceRepo
    let settingsRepo: ISettingRepo
    let fontStyleRepo: IFontStyleRepo
    let themeRepo: IThemeRepo
    let bookmarkRepo: IBookmarkRepo
    let highlightColorRepo: IHighlightColorRepo
    let highlightRepo: IHighlightRepo
    let historyRepo: IHistoryRepo
    let noteRepo: INoteRepo
    
    init(bookRepo: IBookRepo, verseRepo: IVerseRepo, chapterRepo: IChapterRepo, preferenceRepo: IPreferenceRepo, settingsRepo: ISettingRepo, fontStyleRepo: IFontStyleRepo, themeRepo: IThemeRepo, bookmarkRepo: IBookmarkRepo, highlightColorRepo: IHighlightColorRepo, highlightRepo: IHighlightRepo, historyRepo: IHistoryRepo, noteRepo: INoteRepo) {
        self.bookRepo = bookRepo
        self.verseRepo = verseRepo
        self.chapterRepo = chapterRepo
        self.preferenceRepo = preferenceRepo
        self.settingsRepo = settingsRepo
        self.fontStyleRepo = fontStyleRepo
        self.themeRepo = themeRepo
        self.bookmarkRepo = bookmarkRepo
        self.highlightColorRepo = highlightColorRepo
        self.highlightRepo = highlightRepo
        self.historyRepo = historyRepo
        self.noteRepo = noteRepo
    }
    
    var currentSettings: PublishSubject<Setting> = PublishSubject()
    var bookNameAndChapterNumber: PublishSubject<String> = PublishSubject()
    var currentVerses: PublishSubject<[Verse]> = PublishSubject()
    var verseNumber: PublishSubject<Int> = PublishSubject()
    var highlights: PublishSubject<[Highlight]> = PublishSubject()
    var selectedVersesText: PublishSubject<String> = PublishSubject()
    var shareableSelectedVersesText: String = ""
    var verseSelected: PublishSubject<Bool> = PublishSubject()
    var selectedVerses = [Verse]()
    var highlightColorsFontStylesAndThemes: PublishSubject<(highlightColors: [HighlightColor], fontStyles: [FontStyle], themes: [Theme])> = PublishSubject()
    
    fileprivate var currentVerse: Verse?
    fileprivate var currentChapter: Chapter?
    fileprivate var currentBook: Book?
    fileprivate var newBookNameAndChapterNumber = "Genese:1"
    fileprivate var verses = [Verse]()
    fileprivate var chapters = [Verse]()
    fileprivate var highlightsList = [Highlight]()
    fileprivate var currentVersesList = [Verse]()
    
    override func didLoad() {
        super.didLoad()
        self.preferenceRepo.shouldReloadVerses = true
    }
    
    override func willAppear() {
        super.willAppear()
        getBookFromSavedPreferencesOrInitializeWithGenese()
        getUserSettings()
        getHighlightColorsFontStylesAndThemes()
    }
    
    func getUserSettings() {
        subscribe(settingsRepo.getAllSetting(), success: { [weak self] setting in
            self?.currentSettings.onNext(setting)
        })
    }
    
    func getHighlightColorsFontStylesAndThemes() {
        subscribe(Observable.zip(highlightColorRepo.getAllHighlightColors(), fontStyleRepo.getAllFontStyles(), themeRepo.getAllThemes()), success: { [weak self] data in
            self?.highlightColorsFontStylesAndThemes.onNext(data)
        })
    }
    
    func getBookFromSavedPreferencesOrInitializeWithGenese() {
        if preferenceRepo.shouldReloadVerses {
            preferenceRepo.shouldReloadVerses = false
            if preferenceRepo.currentBookId.isEmpty {
                getDefaultBook()
            } else {
                getSavedBook(bookId: preferenceRepo.currentBookId)
            }
        }
    }
    
    fileprivate func getSavedBook(bookId: String) {
        subscribe(bookRepo.getBookById(bookId: bookId), success: { [weak self] book in
            guard let self = self else { return }
            self.currentBook = book
            self.getBookVerses(bookId: self.preferenceRepo.currentBookId)
        })
    }
    
    fileprivate func getDefaultBook() {
        subscribe(bookRepo.getBookByName(bookName: "Genese"), success: { [weak self] book in
            guard let self = self else { return }
            self.preferenceRepo.currentBookId = book.id
            self.currentBook = book
            if let chapter = book.chapters.first {
                self.currentChapter = chapter
                self.preferenceRepo.currentChapterId = chapter.id
            }
            self.getBookVerses(bookId: self.preferenceRepo.currentBookId)
        })
        
    }
    
    fileprivate func getBookVerses(bookId: String) {
        
        let nameAndChapter = newBookNameAndChapterNumber.components(separatedBy: ":")
        newBookNameAndChapterNumber = "\(currentBook!.bookName.capitalized):\(nameAndChapter[1])"
        bookNameAndChapterNumber.onNext(newBookNameAndChapterNumber.replacingOccurrences(of: ":", with: " "))
        
        subscribe(verseRepo.getVersesByBook(bookId: bookId), success: { [weak self] verseList in
            self?.chapters = verseList.distinctBy { $0.chapter.id }
            self?.verses = verseList
            self?.getSavedChapter()
        })
    }
    
    fileprivate func getSavedChapter() {
        if preferenceRepo.currentChapterId.isEmpty {
            getCurrentVerses()
        } else {
            getChapter(chapterId: preferenceRepo.currentChapterId)
        }
    }
    
    fileprivate func getCurrentVerses(chapterId: String? = nil) {
        let chapterId = chapterId ?? chapters[0].id
        currentVersesList = verses.filter { $0.chapter.id == chapterId }
        currentVerses.onNext(currentVersesList)
        
        if let chapter = currentChapter {
            let nameAndChapter = newBookNameAndChapterNumber.components(separatedBy: ":")
            newBookNameAndChapterNumber = "\(nameAndChapter[0]):\(chapter.chapterNumber)"
            bookNameAndChapterNumber.onNext(newBookNameAndChapterNumber.replacingOccurrences(of: ":", with: " "))
        }
        
    }
    
    fileprivate func getChapter(chapterId: String) {
        subscribe(chapterRepo.getChapterById(chapterId: chapterId), success: { [weak self] chapter in
            self?.currentChapter = chapter
            self?.saveHistory(chapter: chapter)
            self?.getCurrentVerses(chapterId: chapter.id)
        })
    }
    
    fileprivate func saveHistory(chapter: Chapter) {
        subscribe(historyRepo.insertHistory(history: [History(book: currentBook!, chapter: chapter)]))
    }
    
    fileprivate func getSavedVerse() {
        getVersesHighlights()
        
        if preferenceRepo.currentVerseId.isEmpty {
            verseNumber.onNext(0)
        } else {
            getVerse(verseId: preferenceRepo.currentVerseId)
        }
    }
    
    fileprivate func getVerse(verseId: String) {
        subscribe(verseRepo.getVerseById(verseId: verseId), success: { [weak self] verse in
            self?.currentVerse = verse
            self?.verseNumber.onNext(verse.number)
        })
    }
    
    fileprivate func getVersesHighlights() {
        subscribe(highlightRepo.getAllHighlights(), success: { [weak self] highlights in
            self?.highlightsList = highlights
            self?.getHighlightedVerses()
        })
    }
    
    fileprivate func getHighlightedVerses() {
        currentVersesList.forEach { verse in
            highlightsList.forEach { highlight in
                if highlight.verse?.id == verse.id {
                    verse.isHighlighted = true
                    verse.highlight = highlight
                }
            }
        }
        currentVerses.onNext(currentVersesList)
        highlights.onNext(highlightsList)
    }
    
    func toggleSelectedVerse(verse: Verse) {
        verse.isSelected = !verse.isSelected
        if verse.isSelected {
            selectedVerses.append(verse)
        } else {
            selectedVerses.removeAll { $0.id == verse.id }
        }
        if selectedVerses.isNotEmpty {
            getSelectedVersesText()
        } else {
            shareableSelectedVersesText = ""
        }
        
        verseSelected.onNext(verse.isSelected)
    }
    
    fileprivate func getSelectedVersesText() {
        
        let selectedVersesList = selectedVerses.sorted { $0.number < $1.number }
        let verses = selectedVersesList.map { $0.number }

        var left: Int?
        var right: Int?
        var groups = [String]()

        for index in (verses.first ?? 0)...(verses.last ?? 0) + 1 {
            if verses.contains(index) {
                if left == nil {
                    left = index
                } else {
                    right = index
                }
            } else {
                guard let leftx = left else { continue }
                
                if let right = right {
                    groups.append("\(leftx)-\(right)")
                } else {
                    groups.append("\(leftx)")
                }
                left = nil
                right = nil
            }
        }
        
        selectedVersesText.onNext("\(newBookNameAndChapterNumber.replacingOccurrences(of: ":", with: " ")) : \(groups.joined(separator: ", "))")
        shareableSelectedVersesText = "\(newBookNameAndChapterNumber)\n\(selectedVersesList.map { "\($0.number). \($0.text)" }.joined(separator: "\n\n"))"
    }
    
}
