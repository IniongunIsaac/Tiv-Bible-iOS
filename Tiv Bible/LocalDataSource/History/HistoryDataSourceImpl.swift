//
//  HistoryDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct HistoryDataSourceImpl: IHistoryDataSource {
    
    let realm: Realm
    
    func getAllHistory() -> Observable<[History]> {
        Observable.array(from: realm.objects(History.self))
    }
    
    func getHistoryById(historyId: String) -> Observable<History> {
        Observable.from(optional: realm.object(ofType: History.self, forPrimaryKey: historyId))
    }
    
    func insertHistory(history: [History]) -> Observable<Void> {
        realm.insertItems(items: history)
    }
    
    func deleteHistory(history: [History]) -> Observable<Void> {
        realm.deleteItems(items: history)
    }
    
    func deleteAllHistory() -> Observable<Void> {
        realm.deleteAllItems(for: History.self)
    }
    
}
