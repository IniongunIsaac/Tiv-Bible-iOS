//
//  IVerseRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IVerseRepo {
    
    func getAllVerses() -> Observable<[Verse]>

    func getVerseById(verseId: String) -> Observable<Verse>

    func getVersesByText(searchText: String) -> Observable<[Verse]>

    func getVersesByChapter(chapterId: String) -> Observable<[Verse]>

    func getVersesByTextAndChapter(searchText: String, chapterId: String) -> Observable<[Verse]>

    func getVersesByBook(bookId: String) -> Observable<[Verse]>

    func insertVerses(verses: [Verse]) -> Observable<Void>

    func deleteVerses(verses: [Verse]) -> Observable<Void>

    func deleteAllVerses() -> Observable<Void>
    
}
