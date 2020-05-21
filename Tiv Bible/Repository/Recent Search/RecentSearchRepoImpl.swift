//
//  RecentSearchRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct RecentSearchRepoImpl: IRecentSearchRepo {
    
    let recentSearchDataSource: IRecentSearchDataSource
    
    func getAllRecentSearches() -> Observable<[RecentSearch]> {
        recentSearchDataSource.getAllRecentSearches()
    }
    
    func getRecentSearchById(recentSearchId: String) -> Observable<RecentSearch> {
        recentSearchDataSource.getRecentSearchById(recentSearchId: recentSearchId)
    }
    
    func insertRecentSearches(recentSearches: [RecentSearch]) -> Observable<Void> {
        recentSearchDataSource.insertRecentSearches(recentSearches: recentSearches)
    }
    
    func deleteRecentSearches(recentSearches: [RecentSearch]) -> Observable<Void> {
        recentSearchDataSource.deleteRecentSearches(recentSearches: recentSearches)
    }
    
    func deleteRecentSearches() -> Observable<Void> {
        recentSearchDataSource.deleteRecentSearches()
    }
    
}
