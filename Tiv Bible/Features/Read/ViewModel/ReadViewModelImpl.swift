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
    
    fileprivate var currentVerse: Verse?
    fileprivate var currentChapter: Chapter?
    fileprivate var currentBook: Book?
    fileprivate var newBookNameAndChapterNumber = "Genese:1"
    fileprivate var verses = [Verse]()
    fileprivate var chapters = [Verse]()
    
    override func didAppear() {
        super.didAppear()
        getUserSettings()
        self.preferenceRepo.shouldReloadVerses = true
    }
    
    fileprivate func getUserSettings() {
        //showLoading()
        runOnBackgroundThenMainThread { [weak self] in
            guard let self = self else { return }
            self.subscribe(self.settingsRepo.getAllSetting(), success: { setting in
                self.currentSettings.onNext(setting)
                //self.showLoading(false)
            })
        }
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
        //showLoading()
        runOnBackgroundThenMainThread { [weak self] in
            guard let self = self else { return }
            self.subscribe(self.bookRepo.getBookById(bookId: bookId), success: { book in
                self.currentBook = book
                self.getBookVerses(bookId: self.preferenceRepo.currentBookId)
            })
        }
    }
    
    fileprivate func getDefaultBook() {
        //showLoading()
        runOnBackgroundThenMainThread { [weak self] in
            guard let self = self else { return }
            self.subscribe(self.bookRepo.getBookByName(bookName: "Genese"), success: { book in
                self.preferenceRepo.currentBookId = book.id
                self.currentBook = book
                if let chapter = book.chapters.first {
                    self.currentChapter = chapter
                    self.preferenceRepo.currentChapterId = chapter.id
                }
                //self.showLoading(false)
                self.getBookVerses(bookId: self.preferenceRepo.currentBookId)
            })
        }
    }
    
    fileprivate func getBookVerses(bookId: String) {
        
        let nameAndChapter = newBookNameAndChapterNumber.components(separatedBy: ":")
        newBookNameAndChapterNumber = "\(currentBook!.bookName.capitalized):\(nameAndChapter[1])"
        bookNameAndChapterNumber.onNext(newBookNameAndChapterNumber.replacingOccurrences(of: ":", with: " "))
        
        runOnBackgroundThenMainThread { [weak self] in
            guard let self = self else { return }
            self.subscribe(self.verseRepo.getVersesByBook(bookId: bookId), success: { verseList in
                self.chapters = verseList.distinctBy { $0.chapter.id }
                self.verses = verseList
                self.getSavedChapter()
            })
        }
    }
    
    fileprivate func getSavedChapter() {
        if preferenceRepo.currentChapterId.isEmpty {
            getCurrentVerses()
        } else {
            getChapter(chapterId: preferenceRepo.currentChapterId)
        }
    }
    
    fileprivate func getCurrentVerses() {
        
    }
    
    fileprivate func getChapter(chapterId: String) {
        runOnBackgroundThenMainThread { [weak self] in
            guard let self = self else { return }
            self.subscribe(self.chapterRepo.getChapterById(chapterId: chapterId), success: { chapter in
                self.saveHistory(chapter: chapter)
            })
        }
    }
    
    fileprivate func saveHistory(chapter: Chapter) {
        
    }
    
}
