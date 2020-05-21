//
//  IThemeDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IThemeDataSource {
    
    func getAllThemes() -> Observable<[Theme]>

    func getThemeById(themeId: String) -> Observable<Theme>
    
    func getThemeByName(name: String) -> Observable<Theme>

    func insertThemes(themes: [Theme]) -> Observable<Void>

    func deleteThemes(themes: [Theme]) -> Observable<Void>

    func deleteAllThemes() -> Observable<Void>
    
}
