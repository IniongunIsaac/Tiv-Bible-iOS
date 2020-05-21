//
//  ThemeDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct ThemeDataSourceImpl: IThemeDataSource {
    
    let realm: Realm
    
    func getAllThemes() -> Observable<[Theme]> {
        Observable.array(from: realm.objects(Theme.self))
    }
    
    func getThemeById(themeId: String) -> Observable<Theme> {
        Observable.from(optional: realm.object(ofType: Theme.self, forPrimaryKey: themeId))
    }
    
    func getThemeByName(name: String) -> Observable<Theme> {
        Observable.from(optional: realm.objects(Theme.self).filter("name LIKE %@", name).first)
    }
    
    func insertThemes(themes: [Theme]) -> Observable<Void> {
        realm.insertItems(items: themes)
    }
    
    func deleteThemes(themes: [Theme]) -> Observable<Void> {
        realm.deleteItems(items: themes)
    }
    
    func deleteAllThemes() -> Observable<Void> {
        realm.deleteAllItems(for: Theme.self)
    }
    
}
