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
    
    fileprivate let bookRepo: IBookRepo
    fileprivate let verseRepo: IVerseRepo
    fileprivate let chapterRepo: IChapterRepo
    fileprivate var preferenceRepo: IPreferenceRepo
    fileprivate let settingsRepo: ISettingRepo
    fileprivate let fontStyleRepo: IFontStyleRepo
    fileprivate let bookmarkRepo: IBookmarkRepo
    fileprivate let highlightColorRepo: IHighlightColorRepo
    fileprivate let highlightRepo: IHighlightRepo
    fileprivate let historyRepo: IHistoryRepo
    fileprivate let noteRepo: INoteRepo
    
    init(bookRepo: IBookRepo, verseRepo: IVerseRepo, chapterRepo: IChapterRepo, preferenceRepo: IPreferenceRepo, settingsRepo: ISettingRepo, fontStyleRepo: IFontStyleRepo, bookmarkRepo: IBookmarkRepo, highlightColorRepo: IHighlightColorRepo, highlightRepo: IHighlightRepo, historyRepo: IHistoryRepo, noteRepo: INoteRepo) {
        self.bookRepo = bookRepo
        self.verseRepo = verseRepo
        self.chapterRepo = chapterRepo
        self.preferenceRepo = preferenceRepo
        self.settingsRepo = settingsRepo
        self.fontStyleRepo = fontStyleRepo
        self.bookmarkRepo = bookmarkRepo
        self.highlightColorRepo = highlightColorRepo
        self.highlightRepo = highlightRepo
        self.historyRepo = historyRepo
        self.noteRepo = noteRepo
    }
    
    var currentSettings: Setting? = nil
    var updateUIWithCurrentSettings: PublishSubject<Bool> = PublishSubject()
    var bookNameAndChapterNumber: PublishSubject<String> = PublishSubject()
    var currentVerses: PublishSubject<[Verse]> = PublishSubject()
    var verseNumber: PublishSubject<Int> = PublishSubject()
    var selectedVersesText: PublishSubject<String> = PublishSubject()
    var shareableSelectedVersesText: String = ""
    var reloadVerses: PublishSubject<Bool> = PublishSubject()
    var selectedVerses = [Verse]()
    var highlightColorsAndFontStyles: PublishSubject<(highlightColors: [HighlightColor], fontStyles: [FontStyle])> = PublishSubject()
    fileprivate var fontStyles = [FontStyle]()
    
    fileprivate var currentChapter: Chapter?
    fileprivate var currentBook: Book?
    fileprivate var newBookNameAndChapterNumber = "Genese:1"
    fileprivate var verses = [Verse]()
    fileprivate var chapters = [Verse]()
    fileprivate var highlightsList = [Highlight]()
    fileprivate var currentVersesList = [Verse]()
    
    var currentTheme: Theme {
        get { preferenceRepo.currentTheme }
        set { preferenceRepo.currentTheme = newValue }
    }
    
    override func didLoad() {
        super.didLoad()
        self.preferenceRepo.shouldReloadVerses = true
        getUserSettings()
        getHighlightColorsAndFontStyles()
    }
    
    override func willAppear() {
        super.willAppear()
        getBookFromSavedPreferencesOrInitializeWithGenese()
    }
    
    func getHighlightColorsAndFontStyles() {
        subscribe(Observable.zip(highlightColorRepo.getAllHighlightColors(), fontStyleRepo.getAllFontStyles()), success: { [weak self] data in
            self?.fontStyles = data.1
            self?.highlightColorsAndFontStyles.onNext(data)
        })
    }
    
    func getBookFromSavedPreferencesOrInitializeWithGenese() {
        preferenceRepo.do {
            if $0.shouldReloadVerses {
                preferenceRepo.shouldReloadVerses = false
                if $0.currentBookId.isEmpty {
                    getDefaultBook()
                } else {
                    getSavedBook(bookId: $0.currentBookId)
                    
                    if $0.shouldScrollToVerse && $0.selectedVerseNumber > 1 {
                        verseNumber.onNext($0.selectedVerseNumber)
                        preferenceRepo.shouldScrollToVerse = false
                        preferenceRepo.selectedVerseNumber = 0
                    }
                    
                }
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
        
        getVersesHighlights()
        
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
    
    fileprivate func getVersesHighlights() {
        highlightsList.removeAll()
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
        
        reloadVerses.onNext(true)
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
    
    func saveBookmarks() {
        let bookmarks = selectedVerses.map { Bookmark(book: currentBook!, chapter: currentChapter!, verse: $0) }
        subscribe(bookmarkRepo.insertBookmarks(bookmarks: bookmarks), success: { [weak self] in
            self?.showMessage("Bookmarks saved successfully!")
        })
    }
    
    func saveNotes(_ notes: String) {
        let note = Note(comment: notes, book: currentBook!, chapter: currentChapter!)
        note.verses.append(objectsIn: selectedVerses.sorted { $0.number < $1.number })
        subscribe(noteRepo.insertNotes(notes: [note]), success: { [weak self] in
            self?.showMessage("Notes saved successfully!")
        })
    }
    
    func setHighlightColorForSelectedVerses(_ color: HighlightColor) {
        let highlights = selectedVerses.map { Highlight(book: currentBook!, chapter: currentChapter!, verse: $0, color: color) }
        subscribe(highlightRepo.insertHighlights(highlights: highlights), success: { [weak self] in
            self?.getVersesHighlights()
        })
    }
    
    func increaseFontSize() {
        guard let currentSettings = currentSettings else { return }
        if currentSettings.fontSize == AppConstants.maxFontSize {
            showMessage("Maximum font size for your device is \(AppConstants.maxFontSize)px", type: .error)
        } else {
            let fontSize = currentSettings.fontSize + 1
            updateUserSettings(currentSettings.newCopy(fontSize: fontSize))
        }
    }
    
    func decreaseFontSize() {
        guard let currentSettings = currentSettings else { return }
        if currentSettings.fontSize == AppConstants.minFontSize {
            showMessage("Minimum font size for your device is \(AppConstants.minFontSize)px", type: .error)
        } else {
            let fontSize = currentSettings.fontSize - 1
            updateUserSettings(currentSettings.newCopy(fontSize: fontSize))
        }
    }
    
    func getUserSettings() {
        subscribe(settingsRepo.getAllSetting(), success: { [weak self] setting in
            self?.currentSettings = setting
            self?.updateUIWithCurrentSettings.onNext(true)
        })
    }
    
    fileprivate func updateUserSettings(_ settings: Setting) {
        subscribe(settingsRepo.updateSettings(setting: settings), success: { [weak self] in
            self?.getUserSettings()
        })
    }
    
    func updateLineSpacing(type: LineSpacingType) {
        updateUserSettings(currentSettings!.newCopy(lineSpacing: type.value))
    }
    
    func updateSelectedFontStyle(_ fontStyle: FontStyle) {
        updateUserSettings(currentSettings!.newCopy(fontStyle: fontStyle))
    }
    
    func removeHighlightsFromSelectedVerses() {
        let selectedHighlightedVerses = selectedVerses.filter { $0.highlight.isNotNil }
        let highlights = selectedHighlightedVerses.compactMap { $0.highlight }
        selectedHighlightedVerses.forEach {
            $0.highlight = nil
            $0.isHighlighted = false
        }
        subscribe(highlightRepo.deleteHighlights(highlights: highlights), success: { [weak self] in
            self?.getVersesHighlights()
        })
    }
    
    func getChapterVerses(number: Int) {
        guard let book = currentBook, let chapter = currentChapter else {
            return
        }
        let chapterNumber = chapter.chapterNumber + number
        
        if chapterNumber <= 0 {
            showMessage("You're currently on the first chapter!", type: .error)
        } else if chapterNumber > chapters.count {
            showMessage("You're currently on the last chapter!", type: .error)
        } else {
            
            if let chapter = book.chapters.first(where: { $0.chapterNumber == chapterNumber }) {
                currentChapter = chapter
                preferenceRepo.shouldReloadVerses = true
                preferenceRepo.currentChapterId = chapter.id
                clearSelectedVerses()
                getCurrentVerses(chapterId: chapter.id)
                saveHistory()
            }
            
        }
    }
    
    fileprivate func clearSelectedVerses() {
        selectedVerses.removeAll()
        shareableSelectedVersesText = ""
        selectedVersesText.onNext("")
    }
    
    fileprivate func saveHistory() {
        let history = History(book: currentBook!, chapter: currentChapter!)
        subscribe(historyRepo.insertHistory(history: [history]))
    }
    
}
