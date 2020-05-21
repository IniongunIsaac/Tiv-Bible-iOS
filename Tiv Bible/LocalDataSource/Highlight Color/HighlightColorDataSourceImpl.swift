//
//  HighlightColorDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct HighlightColorDataSourceImpl: IHighlightColorDataSource {
    
    let realm: Realm
    
    func getAllHighlightColors() -> Observable<[HighlightColor]> {
        Observable.array(from: realm.objects(HighlightColor.self))
    }
    
    func getHighlightColorById(highlightColorId: String) -> Observable<HighlightColor> {
        Observable.from(optional: realm.object(ofType: HighlightColor.self, forPrimaryKey: highlightColorId))
    }
    
    func insertHighlightColors(highlightColors: [HighlightColor]) -> Observable<Void> {
        realm.insertItems(items: highlightColors)
    }
    
    func deleteHighlightColors(highlightColors: [HighlightColor]) -> Observable<Void> {
        realm.deleteItems(items: highlightColors)
    }
    
    func deleteAllHighlightColors() -> Observable<Void> {
        realm.deleteAllItems(for: HighlightColor.self)
    }
    
}
