//
//  ReferenceViewModelImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

class ReferenceViewModelImpl: BaseViewModel, IReferenceViewModel {
    
    var books: [Book] = []
    var chapters: [Chapter] = []
    var verses: [Verse] = []
    var showReferenceSegment: PublishSubject<ReferenceSegment> = PublishSubject()
    var showReaderView: PublishSubject<Bool> = PublishSubject()
    
    fileprivate let booksRepo: IBookRepo
    fileprivate let chaptersRepo: IChapterRepo
    fileprivate let versesRepo: IVerseRepo
    fileprivate let historyRepo: IHistoryRepo
    fileprivate var preferenceRepo: IPreferenceRepo
    
    fileprivate var selectedChapter: Chapter!
    fileprivate var selectedBook: Book!
    fileprivate var selectedVerse: Verse!
    
    init(booksRepo: IBookRepo, chaptersRepo: IChapterRepo, versesRepo: IVerseRepo, historyRepo: IHistoryRepo, preferenceRepo: IPreferenceRepo) {
        self.booksRepo = booksRepo
        self.chaptersRepo = chaptersRepo
        self.versesRepo = versesRepo
        self.historyRepo = historyRepo
        self.preferenceRepo = preferenceRepo
    }
    
    func getBooks() {
        subscribe(booksRepo.getAllBooks(), viewControllerType: .bottomSheet, success: { [weak self] books in
            self?.books = books
            self?.showReferenceSegment.onNext(.books)
        })
    }
    
    func getBookChapters(_ book: Book) {
        selectedBook = book
        chapters = book.chapters.toArray()
        showReferenceSegment.onNext(.chapters)
    }
    
    func getChapterVerses(_ chapter: Chapter) {
        selectedChapter = chapter
        verses = chapter.verses.toArray()
        showReferenceSegment.onNext(.verses)
    }
    
    func handleVerseSelected(_ verse: Verse) {
        selectedVerse = verse
        preferenceRepo.currentBookId = selectedBook.id
        preferenceRepo.currentChapterId = selectedChapter.id
        preferenceRepo.currentVerseId = selectedVerse.id
        preferenceRepo.selectedVerseNumber = selectedVerse.number
        preferenceRepo.shouldScrollToVerse = true
        preferenceRepo.shouldReloadVerses = true
        let history = History(book: selectedBook, chapter: selectedChapter)
        subscribe(historyRepo.insertHistory(history: [history]), viewControllerType: .bottomSheet, success: { [weak self] in
            self?.showReaderView.onNext(true)
        })
    }
    
}
