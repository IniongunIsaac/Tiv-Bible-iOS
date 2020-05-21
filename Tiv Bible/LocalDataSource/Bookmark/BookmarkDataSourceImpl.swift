//
//  BookmarkDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct BookmarkDataSourceImpl: IBookmarkDataSource {
    
    let realm: Realm
    
    func getBookmarks() -> Observable<[Bookmark]> {
        return Observable.array(from: realm.objects(Bookmark.self))
    }
    
    func getBookmarkByDate(bookmarkedOn: Date) -> Observable<[Bookmark]> {
        return Observable.array(from: realm.objects(Bookmark.self).filter("bookmarkedOn == %@", bookmarkedOn).sorted(byKeyPath: "bookmarkedOn", ascending: false))
    }
    
    func getBookmarkByVerse(verseId: String) -> Observable<Bookmark> {
        return Observable.from(optional: realm.objects(Bookmark.self).filter("verse.id = %@", verseId).first)
    }
    
    func insertBookmarks(bookmarks: [Bookmark]) -> Observable<Void> {
        realm.insertItems(items: bookmarks)
    }
    
    func deleteBookmarks(bookmarks: [Bookmark]) -> Observable<Void> {
        realm.deleteItems(items: bookmarks)
    }
    
    
}
