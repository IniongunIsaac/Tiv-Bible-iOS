//
//  VersionDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct VersionDataSourceImpl: IVersionDataSource {
    
    let realm: Realm
    
    func getAllVersions() -> Observable<[Version]> {
        Observable.array(from: realm.objects(Version.self))
    }
    
    func getVersionById(versionId: String) -> Observable<Version> {
        Observable.from(optional: realm.object(ofType: Version.self, forPrimaryKey: versionId))
    }
    
    func getVersionByName(versionName: String) -> Observable<Version> {
        Observable.from(optional: realm.objects(Version.self).filter("name LIKE %@", versionName).first)
    }
    
    func insertVersions(versions: [Version]) -> Observable<Void> {
        realm.insertItems(items: versions)
    }
    
    func deleteVersions(versions: [Version]) -> Observable<Void> {
        realm.deleteItems(items: versions)
    }
    
    func deleteAllVersions() -> Observable<Void> {
        realm.deleteAllItems(for: Version.self)
    }
    
}
