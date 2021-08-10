//
//  IMoreViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol IMoreViewModel {
    
    var bookmarks: PublishSubject<[Bookmark]> { get set }
    
    var showReaderView: PublishSubject<Bool> { get }
    
    func getBookmarks()
    
    func deleteBookmark(_ bookmark: Bookmark)
    
    func readFullChapter(bookId: String, chapterId: String, verseId: String, verseNumber: Int)
    
}
