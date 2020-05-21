//
//  RecentSearchDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct RecentSearchDataSourceImpl: IRecentSearchDataSource {
    
    let realm: Realm
    
    func getAllRecentSearches() -> Observable<[RecentSearch]> {
        Observable.array(from: realm.objects(RecentSearch.self))
    }
    
    func getRecentSearchById(recentSearchId: String) -> Observable<RecentSearch> {
        Observable.from(optional: realm.object(ofType: RecentSearch.self, forPrimaryKey: recentSearchId))
    }
    
    func insertRecentSearches(recentSearches: [RecentSearch]) -> Observable<Void> {
        realm.insertItems(items: recentSearches)
    }
    
    func deleteRecentSearches(recentSearches: [RecentSearch]) -> Observable<Void> {
        realm.deleteItems(items: recentSearches)
    }
    
    func deleteRecentSearches() -> Observable<Void> {
        realm.deleteAllItems(for: RecentSearch.self)
    }
    
}
