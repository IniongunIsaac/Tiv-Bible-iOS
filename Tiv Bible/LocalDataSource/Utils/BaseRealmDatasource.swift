//
//  BaseRealmDatasource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 02/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

class BaseRealmDatasource {
    
    var kRealm: Realm { preconditionFailure("Subclass of BaseRealmDatasource must provide an instance of Realm!") }
    
    func getAll<T: Object>(obj: T.Type) -> Observable<[T]> {
        Observable.array(from: kRealm.objects(T.self))
    }
    
    func insert<T: Object>(objs: [T]) -> Observable<Void> {
        kRealm.insertItems(items: objs)
    }
    
    func delete<T: Object>(objs: [T]) -> Observable<Void> {
        kRealm.deleteItems(items: objs)
    }
    
    func deleteAll<T: Object>(obj: T.Type) -> Observable<Void> {
        kRealm.deleteAllItems(for: T.self)
    }
    
    func getById<T: Object>(obj: T.Type, id: Any) -> Observable<T> {
        Observable.from(optional: kRealm.object(ofType: T.self, forPrimaryKey: id))
    }
    
    func getByProperty<T: Object>(obj: T.Type, property: String, value: Any) -> Observable<T> {
        Observable.from(optional: kRealm.objects(T.self).filter("\(property) LIKE %@", value).first)
    }
    
    func getByPropertyList<T: Object>(obj: T.Type, property: String, value: Any) -> Observable<[T]> {
        Observable.from(optional: kRealm.objects(T.self).filter("\(property) LIKE %@", value).toArray())
    }
    
}
