//
//  ISettingDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol ISettingDataSource {
    
    func getAllSettings() -> Observable<[Setting]>
    
    func getAllSetting() -> Observable<Setting>

    func getSettingsById(settingId: String) -> Observable<Setting>
    
    func insertSettings(settings: [Setting]) -> Observable<Void>

    func deleteSettings(settings: [Setting]) -> Observable<Void>

    func deleteAllSettings() -> Observable<Void>

    func updateSettings(setting: Setting) -> Observable<Void>
    
}
