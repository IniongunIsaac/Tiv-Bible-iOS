//
//  SettingRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct SettingRepoImpl: ISettingRepo {
    
    let settingsDataSource: ISettingDataSource
    
    func getAllSettings() -> Observable<[Setting]> {
        settingsDataSource.getAllSettings()
    }
    
    func getSettingsById(settingId: String) -> Observable<Setting> {
        settingsDataSource.getSettingsById(settingId: settingId)
    }
    
    func insertSettings(settings: [Setting]) -> Observable<Void> {
        settingsDataSource.insertSettings(settings: settings)
    }
    
    func deleteSettings(settings: [Setting]) -> Observable<Void> {
        settingsDataSource.deleteSettings(settings: settings)
    }
    
    func deleteAllSettings() -> Observable<Void> {
        settingsDataSource.deleteAllSettings()
    }
    
    func updateSettings(setting: Setting) -> Observable<Void> {
        settingsDataSource.updateSettings(setting: setting)
    }
    
}
