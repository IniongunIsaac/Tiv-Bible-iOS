//
//  VerseRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct VerseRepoImpl: IVerseRepo {
    
    let verseDataSource: IVerseDataSource
    
    func getAllVerses() -> Observable<[Verse]> {
        verseDataSource.getAllVerses()
    }
    
    func getVerseById(verseId: String) -> Observable<Verse> {
        verseDataSource.getVerseById(verseId: verseId)
    }
    
    func getVersesByText(searchText: String) -> Observable<[Verse]> {
        verseDataSource.getVersesByText(searchText: searchText)
    }
    
    func getVersesByChapter(chapterId: String) -> Observable<[Verse]> {
        verseDataSource.getVersesByChapter(chapterId: chapterId)
    }
    
    func getVersesByTextAndChapter(searchText: String, chapterId: String) -> Observable<[Verse]> {
        verseDataSource.getVersesByTextAndChapter(searchText: searchText, chapterId: chapterId)
    }
    
    func getVersesByBook(bookId: String) -> Observable<[Verse]> {
        verseDataSource.getVersesByBook(bookId: bookId)
    }
    
    func insertVerses(verses: [Verse]) -> Observable<Void> {
        verseDataSource.insertVerses(verses: verses)
    }
    
    func deleteVerses(verses: [Verse]) -> Observable<Void> {
        verseDataSource.deleteVerses(verses: verses)
    }
    
    func deleteAllVerses() -> Observable<Void> {
        verseDataSource.deleteAllVerses()
    }
    
}
