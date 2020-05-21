//
//  VerseDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct VerseDataSourceImpl: IVerseDataSource {
    
    let realm: Realm
    
    func getAllVerses() -> Observable<[Verse]> {
        Observable.array(from: realm.objects(Verse.self))
    }
    
    func getVerseById(verseId: String) -> Observable<Verse> {
        Observable.from(optional: realm.object(ofType: Verse.self, forPrimaryKey: verseId))
    }
    
    func getVersesByText(searchText: String) -> Observable<[Verse]> {
        Observable.array(from: realm.objects(Verse.self).filter("text LIKE %@", searchText))
    }
    
    func getVersesByChapter(chapterId: String) -> Observable<[Verse]> {
        Observable.array(from: realm.objects(Verse.self).filter("chapter.id = %@", chapterId).sorted(byKeyPath: "number", ascending: true))
    }
    
    func getVersesByTextAndChapter(searchText: String, chapterId: String) -> Observable<[Verse]> {
        Observable.array(from: realm.objects(Verse.self).filter("text LIKE %@ chapter.id = %@", searchText, chapterId).sorted(byKeyPath: "number", ascending: true))
    }
    
    func getVersesByBook(bookId: String) -> Observable<[Verse]> {
        Observable.from(optional: realm.objects(Verse.self).filter("chapter.book.id = %@", bookId).sorted (by: { $0.chapter.book.orderNo < $1.chapter.book.orderNo && $0.number < $1.number }))
    }
    
    func insertVerses(verses: [Verse]) -> Observable<Void> {
        realm.insertItems(items: verses)
    }
    
    func deleteVerses(verses: [Verse]) -> Observable<Void> {
        realm.deleteItems(items: verses)
    }
    
    func deleteAllVerses() -> Observable<Void> {
        realm.deleteAllItems(for: Verse.self)
    }
    
}
