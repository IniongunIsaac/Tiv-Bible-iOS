//
//  IChapterRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IChapterRepo {
    
    func getAllChapters() -> Observable<[Chapter]>

    func getChapterById(chapterId: String) -> Observable<Chapter>

    func getChaptersByBook(bookId: String) -> Observable<[Chapter]>

    func getChapterByBookAndChapterNumber(bookId: String, chapterNumber: Int) -> Observable<Chapter>

    func insertChapters(chapters: [Chapter]) -> Observable<Void>
    
    func deleteChapters(chapters: [Chapter]) -> Observable<Void>

    func deleteAllChapters() -> Observable<Void>
    
}
