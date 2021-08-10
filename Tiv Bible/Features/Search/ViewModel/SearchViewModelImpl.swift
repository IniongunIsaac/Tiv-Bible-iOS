//
//  SearchViewModelImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

class SearchViewModelImpl: BaseViewModel, ISearchViewModel {
    
    var books: [Book] = []
    var chapters: [Chapter] = []
    var verses: PublishSubject<[Verse]> = PublishSubject()
    var showReaderView: PublishSubject<Bool> = PublishSubject()
    var showReferenceSegment: PublishSubject<ReferenceSegment> = PublishSubject()
    
    fileprivate let booksRepo: IBookRepo
    fileprivate let chaptersRepo: IChapterRepo
    fileprivate var preferenceRepo: IPreferenceRepo
    fileprivate let versesRepo: IVerseRepo
    fileprivate let historyRepo: IHistoryRepo
    
    var selectedChapter: Chapter? = nil
    var selectedBook: Book? = nil
    fileprivate var selectedVerse: Verse?
    fileprivate var allVerses = [Verse]()
    
    init(booksRepo: IBookRepo, chaptersRepo: IChapterRepo, preferenceRepo: IPreferenceRepo, versesRepo: IVerseRepo, historyRepo: IHistoryRepo) {
        self.booksRepo = booksRepo
        self.chaptersRepo = chaptersRepo
        self.preferenceRepo = preferenceRepo
        self.versesRepo = versesRepo
        self.historyRepo = historyRepo
    }
    
    override func didLoad() {
        super.didLoad()
        getBooks(showBookReferences: false)
        getAllVerses()
    }
    
    fileprivate func getAllVerses() {
        subscribe(versesRepo.getAllVerses(), success: { [weak self] verses in
            self?.allVerses = verses
        })
    }
    
    func getBooks(showBookReferences: Bool) {
        subscribe(booksRepo.getAllBooks(), success: { [weak self] books in
            self?.books = books
            if showBookReferences {
                self?.showReferenceSegment.onNext(.books)
            }
        })
    }
    
    func getBookChapters(_ book: Book, showChapterReferences: Bool) {
        selectedBook = book
        chapters = book.chapters.toArray()
        if showChapterReferences {
            showReferenceSegment.onNext(.chapters)
        }
    }
    
    func search(text: String) {
        let filteredResults = allVerses.filter { $0.text.contains(text) }
        var results = [Verse]()
        
        if selectedBook.isNotNil && selectedChapter.isNil {
            results = filteredResults.filter { $0.book.id == selectedBook!.id }
        } else if selectedBook.isNotNil && selectedChapter.isNotNil {
            results = filteredResults.filter { $0.book.id == selectedBook!.id && $0.chapter.id == selectedChapter!.id }
        } else if selectedBook.isNil && selectedChapter.isNil {
            results = filteredResults
        }
        
        verses.onNext(results)
    }
    
    func handleVerseSelected(_ verse: Verse) {
        let book = verse.book
        let chapter = verse.chapter
        
        preferenceRepo.currentBookId = book.id
        preferenceRepo.currentChapterId = chapter.id
        preferenceRepo.currentVerseId = verse.id
        preferenceRepo.selectedVerseNumber = verse.number
        preferenceRepo.shouldScrollToVerse = true
        preferenceRepo.shouldReloadVerses = true
        
        let history = History(book: book, chapter: chapter)
        subscribe(historyRepo.insertHistory(history: [history]), viewControllerType: .bottomSheet, success: { [weak self] in
            self?.showReaderView.onNext(true)
        })
    }
    
}
