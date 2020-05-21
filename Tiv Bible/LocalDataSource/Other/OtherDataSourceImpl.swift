//
//  OtherDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct OtherDataSourceImpl: IOtherDataSource {
    
    let realm: Realm
    
    func getAllOthers() -> Observable<[Other]> {
        Observable.array(from: realm.objects(Other.self))
    }
    
    func getOtherById(otherId: String) -> Observable<Other> {
        Observable.from(optional: realm.object(ofType: Other.self, forPrimaryKey: otherId))
    }
    
    func getOtherByText(searchText: String) -> Observable<Other> {
        Observable.from(optional: realm.objects(Other.self).filter("title LIKE %@", searchText).first)
    }
    
    func insertOthers(others: [Other]) -> Observable<Void> {
        realm.insertItems(items: others)
    }
    
    func deleteOthers(others: [Other]) -> Observable<Void> {
        realm.deleteItems(items: others)
    }
    
    func deleteAllOthers() -> Observable<Void> {
        realm.deleteAllItems(for: Other.self)
    }
    
}
