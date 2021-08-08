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
    }
    
    func getChapterVerses(_ chapter: Chapter) {
        selectedChapter = chapter
    }
    
    func handleVerseSelected(_ verse: Verse) {
        selectedVerse = verse
    }
    
}
