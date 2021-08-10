//
//  MoreViewModelImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

class MoreViewModelImpl: BaseViewModel, IMoreViewModel {
    
    var bookmarks: PublishSubject<[Bookmark]> = PublishSubject()
    
    fileprivate let bookmarksRepo: IBookmarkRepo
    fileprivate let notesRepo: INoteRepo
    fileprivate let highlightsRepo: IHighlightRepo
    fileprivate let historyRepo: IHistoryRepo
    fileprivate let settingsRepo: ISettingRepo
    fileprivate let othersRepo: IOtherRepo
    fileprivate var preferenceRepo: IPreferenceRepo
    
    init(bookmarksRepo: IBookmarkRepo, notesRepo: INoteRepo, highlightsRepo: IHighlightRepo, historyRepo: IHistoryRepo, settingsRepo: ISettingRepo, othersRepo: IOtherRepo, preferenceRepo: IPreferenceRepo) {
        self.bookmarksRepo = bookmarksRepo
        self.notesRepo = notesRepo
        self.highlightsRepo = highlightsRepo
        self.historyRepo = historyRepo
        self.settingsRepo = settingsRepo
        self.othersRepo = othersRepo
        self.preferenceRepo = preferenceRepo
    }
    
    func getBookmarks() {
        subscribe(bookmarksRepo.getBookmarks(), success: { [weak self] bookmarks in
            self?.bookmarks.onNext(bookmarks)
        })
    }
    
    func deleteBookmark(_ bookmark: Bookmark) {
        subscribe(bookmarksRepo.deleteBookmarks(bookmarks: [bookmark]), success: { [weak self] in
            self?.getBookmarks()
        })
    }
    
}
