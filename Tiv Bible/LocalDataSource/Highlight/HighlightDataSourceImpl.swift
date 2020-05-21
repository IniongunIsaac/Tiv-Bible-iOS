//
//  HighlightDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct HighlightDataSourceImpl: IHighlightDataSource {
    
    let realm: Realm
    
    func getAllHighlights() -> Observable<[Highlight]> {
        Observable.array(from: realm.objects(Highlight.self))
    }
    
    func getHighlightById(id: String) -> Observable<Highlight> {
        Observable.from(optional: realm.object(ofType: Highlight.self, forPrimaryKey: id))
    }
    
    func getHighlightsByDate(highlightedOn: Date) -> Observable<[Highlight]> {
        Observable.array(from: realm.objects(Highlight.self).filter("highlightedOn == %@", highlightedOn).sorted(byKeyPath: "highlightedOn", ascending: false))
    }
    
    func insertHighlights(highlights: [Highlight]) -> Observable<Void> {
        realm.insertItems(items: highlights)
    }
    
    func deleteHighlights(highlights: [Highlight]) -> Observable<Void> {
        realm.deleteItems(items: highlights)
    }
    
    func deleteAllHighlights() -> Observable<Void> {
        realm.deleteAllItems(for: Highlight.self)
    }

}
