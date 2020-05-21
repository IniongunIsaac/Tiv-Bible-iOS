//
//  ChapterRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct ChapterRepoImpl: IChapterRepo {
    
    let chapterDataSource: IChapterDataSource
    
    func getAllChapters() -> Observable<[Chapter]> {
        chapterDataSource.getAllChapters()
    }
    
    func getChapterById(chapterId: String) -> Observable<Chapter> {
        chapterDataSource.getChapterById(chapterId: chapterId)
    }
    
    func getChaptersByBook(bookId: String) -> Observable<[Chapter]> {
        chapterDataSource.getChaptersByBook(bookId: bookId)
    }
    
    func getChapterByBookAndChapterNumber(bookId: String, chapterNumber: Int) -> Observable<Chapter> {
        chapterDataSource.getChapterByBookAndChapterNumber(bookId: bookId, chapterNumber: chapterNumber)
    }
    
    func insertChapters(chapters: [Chapter]) -> Observable<Void> {
        chapterDataSource.insertChapters(chapters: chapters)
    }
    
    func deleteChapters(chapters: [Chapter]) -> Observable<Void> {
        chapterDataSource.deleteChapters(chapters: chapters)
    }
    
    func deleteAllChapters() -> Observable<Void> {
        chapterDataSource.deleteAllChapters()
    }
    
}
