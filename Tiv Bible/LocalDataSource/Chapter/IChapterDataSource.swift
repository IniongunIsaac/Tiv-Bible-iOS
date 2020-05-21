//
//  IChapterDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IChapterDataSource {
    
    func getAllChapters() -> Observable<[Chapter]>

    //@Query("select * from Chapter where id = :chapterId ")
    func getChapterById(chapterId: String) -> Observable<Chapter>

    //@Query("select * from Chapter where book_id = :bookId ")
    func getChaptersByBook(bookId: String) -> Observable<[Chapter]>

   // @Query("select * from Chapter where book_id = :bookId and chapter_number = :chapterNumber")
    func getChapterByBookAndChapterNumber(bookId: String, chapterNumber: Int) -> Observable<Chapter>

    func insertChapters(chapters: [Chapter]) -> Observable<Void>
    
    func deleteChapters(chapters: [Chapter]) -> Observable<Void>

    func deleteAllChapters() -> Observable<Void>
    
}
