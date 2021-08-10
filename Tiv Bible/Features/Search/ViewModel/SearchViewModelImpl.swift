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
    var verses: [Verse] = []
    var showReaderView: PublishSubject<Bool> = PublishSubject()
    var showReferenceSegment: PublishSubject<ReferenceSegment> = PublishSubject()
    
    fileprivate let booksRepo: IBookRepo
    fileprivate let chaptersRepo: IChapterRepo
    fileprivate var preferenceRepo: IPreferenceRepo
    
    var selectedChapter: Chapter? = nil
    var selectedBook: Book? = nil
    fileprivate var selectedVerse: Verse?
    
    init(booksRepo: IBookRepo, chaptersRepo: IChapterRepo, preferenceRepo: IPreferenceRepo) {
        self.booksRepo = booksRepo
        self.chaptersRepo = chaptersRepo
        self.preferenceRepo = preferenceRepo
    }
    
    override func didLoad() {
        super.didLoad()
        getBooks(showBookReferences: false)
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
    
}
