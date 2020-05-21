//
//  BookmarkRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct BookmarkRepoImpl: IBookmarkRepo {
    
    let bookmarksDataSource: IBookmarkDataSource
    
    func getBookmarks() -> Observable<[Bookmark]> {
        bookmarksDataSource.getBookmarks()
    }
    
    func getBookmarkByDate(bookmarkedOn: Date) -> Observable<[Bookmark]> {
        bookmarksDataSource.getBookmarkByDate(bookmarkedOn: bookmarkedOn)
    }
    
    func getBookmarkByVerse(verseId: String) -> Observable<Bookmark> {
        bookmarksDataSource.getBookmarkByVerse(verseId: verseId)
    }
    
    func insertBookmarks(bookmarks: [Bookmark]) -> Observable<Void> {
        bookmarksDataSource.insertBookmarks(bookmarks: bookmarks)
    }
    
    func deleteBookmarks(bookmarks: [Bookmark]) -> Observable<Void> {
        bookmarksDataSource.deleteBookmarks(bookmarks: bookmarks)
    }
    
    func deleteAllBookmarks() -> Observable<Void> {
        bookmarksDataSource.deleteAllBookmarks()
    }
    
}
