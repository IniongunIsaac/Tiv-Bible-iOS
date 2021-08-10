//
//  ISearchViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ISearchViewModel: Scopable {
    
    var books: [Book] { get set }
    
    var chapters: [Chapter] { get set }
    
    var verses: PublishSubject<[Verse]> { get }
    
    var showReaderView: PublishSubject<Bool> { get }
    
    var showReferenceSegment: PublishSubject<ReferenceSegment> { get }
    
    var selectedBook: Book? { get set }
    
    var selectedChapter: Chapter? { get set }
    
    func getBooks(showBookReferences: Bool)
    
    func getBookChapters(_ book: Book, showChapterReferences: Bool)
    
    func search(text: String)
    
    func handleVerseSelected(_ verse: Verse)
    
}
