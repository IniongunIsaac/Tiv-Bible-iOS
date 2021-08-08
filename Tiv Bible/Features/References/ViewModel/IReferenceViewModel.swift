//
//  IReferenceViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IReferenceViewModel: Scopable {
    
    var books: [Book] { get set }
    
    var chapters: [Chapter] { get set }
    
    var verses: [Verse] { get set }
    
    var showReferenceSegment: PublishSubject<ReferenceSegment> { get }
    
    func getBooks()
    
    func getBookChapters(_ book: Book)
    
    func getChapterVerses(_ chapter: Chapter)
    
    func handleVerseSelected(_ verse: Verse)
}
