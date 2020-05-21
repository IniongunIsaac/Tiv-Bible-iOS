//
//  IBookmarkDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IBookmarkDataSource {
    
    func getBookmarks() -> Observable<[Bookmark]>

    //@Query("select * from Bookmark where bookmarked_on = :bookmarkedOn order by datetime(bookmarked_on) desc")
    func getBookmarkByDate(bookmarkedOn: Date) -> Observable<[Bookmark]>

    func getBookmarkByVerse(verseId: String) -> Observable<Bookmark>

    func insertBookmarks(bookmarks: [Bookmark]) -> Observable<Void>

    func deleteBookmarks(bookmarks: [Bookmark]) -> Observable<Void>
    
}
