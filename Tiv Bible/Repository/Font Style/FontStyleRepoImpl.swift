//
//  FontStyleRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct FontStyleRepoImpl: IFontStyleRepo {
    
    let fontStyleDataSource: IFontStyleDataSource
    
    func getAllFontStyles() -> Observable<[FontStyle]> {
        fontStyleDataSource.getAllFontStyles()
    }
    
    func getFontStyleByName(fontStyleName: String) -> Observable<FontStyle> {
        fontStyleDataSource.getFontStyleByName(fontStyleName: fontStyleName)
    }
    
    func getFontStyleById(fontStyleId: String) -> Observable<FontStyle> {
        fontStyleDataSource.getFontStyleById(fontStyleId: fontStyleId)
    }
    
    func insertFontStyles(fontStyles: [FontStyle]) -> Observable<Void> {
        fontStyleDataSource.insertFontStyles(fontStyles: fontStyles)
    }
    
    func deleteFontStyles(fontStyles: [FontStyle]) -> Observable<Void> {
        fontStyleDataSource.deleteFontStyles(fontStyles: fontStyles)
    }
    
    func deleteAllFontStyles() -> Observable<Void> {
        fontStyleDataSource.deleteAllFontStyles()
    }
    
}
