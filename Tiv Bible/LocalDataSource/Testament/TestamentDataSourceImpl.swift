//
//  TestamentDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct TestamentDataSourceImpl: ITestamentDataSource {
    
    let realm: Realm
    
    func getAllTestaments() -> Observable<[Testament]> {
        Observable.array(from: realm.objects(Testament.self))
    }
    
    func getTestamentById(testamentId: String) -> Observable<Testament> {
        Observable.from(optional: realm.object(ofType: Testament.self, forPrimaryKey: testamentId))
    }
    
    func getTestamentByName(testamentName: String) -> Observable<Testament> {
        Observable.from(optional: realm.objects(Testament.self).filter("name = %@", testamentName).first)
    }
    
    func insertTestaments(testaments: [Testament]) -> Observable<Void> {
        realm.insertItems(items: testaments)
    }
    
    func deleteTestaments(testaments: [Testament]) -> Observable<Void> {
        realm.deleteItems(items: testaments)
    }
    
    func deleteAllTestaments() -> Observable<Void> {
        realm.deleteAllItems(for: Testament.self)
    }
    
}
