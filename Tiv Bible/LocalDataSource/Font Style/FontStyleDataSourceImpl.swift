//
//  FontStyleDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct FontStyleDataSourceImpl: IFontStyleDataSource {
    
    let realm: Realm
    
    func getAllFontStyles() -> Observable<[FontStyle]> {
        Observable.array(from: realm.objects(FontStyle.self))
    }
    
    func getFontStyleByName(fontStyleName: String) -> Observable<FontStyle> {
        Observable.from(optional: realm.objects(FontStyle.self).filter("name = %@", fontStyleName).first)
    }
    
    func getFontStyleById(fontStyleId: String) -> Observable<FontStyle> {
        Observable.from(optional: realm.object(ofType: FontStyle.self, forPrimaryKey: fontStyleId))
    }
    
    func insertFontStyles(fontStyles: [FontStyle]) -> Observable<Void> {
        realm.insertItems(items: fontStyles)
    }
    
    func deleteFontStyles(fontStyles: [FontStyle]) -> Observable<Void> {
        realm.deleteItems(items: fontStyles)
    }
    
    func deleteAllFontStyles() -> Observable<Void> {
        realm.deleteAllItems(for: FontStyle.self)
    }
    
}
