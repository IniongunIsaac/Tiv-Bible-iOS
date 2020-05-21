//
//  ChapterDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct ChapterDataSourceImpl: IChapterDataSource {
    
    let realm: Realm
    
    func getAllChapters() -> Observable<[Chapter]> {
        Observable.array(from: realm.objects(Chapter.self))
    }
    
    func getChapterById(chapterId: String) -> Observable<Chapter> {
        Observable.from(optional: realm.object(ofType: Chapter.self, forPrimaryKey: chapterId))
    }
    
    func getChaptersByBook(bookId: String) -> Observable<[Chapter]> {
        Observable.array(from: realm.objects(Chapter.self).filter("book.id = %@", bookId))
    }
    
    func getChapterByBookAndChapterNumber(bookId: String, chapterNumber: Int) -> Observable<Chapter> {
        Observable.from(optional: realm.objects(Chapter.self).filter("book.id = %@ AND chapterNumber = %@", bookId, chapterNumber).first)
    }
    
    func insertChapters(chapters: [Chapter]) -> Observable<Void> {
        realm.insertItems(items: chapters)
    }
    
    func deleteChapters(chapters: [Chapter]) -> Observable<Void> {
        realm.deleteItems(items: chapters)
    }
    
    func deleteAllChapters() -> Observable<Void> {
        realm.deleteAllItems(for: Chapter.self)
    }
    
}
