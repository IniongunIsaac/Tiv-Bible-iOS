//
//  IRecentSearchDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IRecentSearchDataSource {
    
    func getAllRecentSearches() -> Observable<[RecentSearch]>

    func getRecentSearchById(recentSearchId: String) -> Observable<RecentSearch>

    func insertRecentSearches(recentSearches: [RecentSearch]) -> Observable<Void>

    func deleteRecentSearches(recentSearches: [RecentSearch]) -> Observable<Void>

    func deleteRecentSearches() -> Observable<Void>
    
}
