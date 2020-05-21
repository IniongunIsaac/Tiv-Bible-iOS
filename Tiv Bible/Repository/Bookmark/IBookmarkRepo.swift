//
//  IBookmarkRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IBookmarkRepo {
    
    func getBookmarks() -> Observable<[Bookmark]>

    func getBookmarkByDate(bookmarkedOn: Date) -> Observable<[Bookmark]>

    func getBookmarkByVerse(verseId: String) -> Observable<Bookmark>

    func insertBookmarks(bookmarks: [Bookmark]) -> Observable<Void>

    func deleteBookmarks(bookmarks: [Bookmark]) -> Observable<Void>
    
    func deleteAllBookmarks() -> Observable<Void>
    
}
