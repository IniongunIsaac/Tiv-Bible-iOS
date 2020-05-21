//
//  ThemeRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct ThemeRepoImpl: IThemeRepo {
    
    let themeDataSource: IThemeDataSource
    
    func getAllThemes() -> Observable<[Theme]> {
        themeDataSource.getAllThemes()
    }
    
    func getThemeById(themeId: String) -> Observable<Theme> {
        themeDataSource.getThemeById(themeId: themeId)
    }
    
    func getThemeByName(name: String) -> Observable<Theme> {
        themeDataSource.getThemeByName(name: name)
    }
    
    func insertThemes(themes: [Theme]) -> Observable<Void> {
        themeDataSource.insertThemes(themes: themes)
    }
    
    func deleteThemes(themes: [Theme]) -> Observable<Void> {
        themeDataSource.deleteThemes(themes: themes)
    }
    
    func deleteAllThemes() -> Observable<Void> {
        themeDataSource.deleteAllThemes()
    }
    
}
