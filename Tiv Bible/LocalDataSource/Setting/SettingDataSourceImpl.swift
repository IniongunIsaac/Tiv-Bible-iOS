//
//  SettingDataSourceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

struct SettingDataSourceImpl: ISettingDataSource {
    
    let realm: Realm
    
    func getAllSettings() -> Observable<[Setting]> {
        Observable.array(from: realm.objects(Setting.self))
    }
    
    func getAllSetting() -> Observable<Setting> {
        Observable.from(optional: realm.objects(Setting.self).first)
    }
    
    func getSettingsById(settingId: String) -> Observable<Setting> {
        Observable.from(optional: realm.object(ofType: Setting.self, forPrimaryKey: settingId))
    }
    
    func insertSettings(settings: [Setting]) -> Observable<Void> {
        realm.insertItems(items: settings)
    }
    
    func deleteSettings(settings: [Setting]) -> Observable<Void> {
        realm.deleteItems(items: settings)
    }
    
    func deleteAllSettings() -> Observable<Void> {
        realm.deleteAllItems(for: Setting.self)
    }
    
    func updateSettings(setting: Setting) -> Observable<Void> {
        realm.updateItems(items: [setting])
    }
    
}
