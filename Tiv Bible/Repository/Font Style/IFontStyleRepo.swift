//
//  IFontStyleRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IFontStyleRepo {
    
    func getAllFontStyles() -> Observable<[FontStyle]>

    func getFontStyleByName(fontStyleName: String) -> Observable<FontStyle>

    func getFontStyleById(fontStyleId: String) -> Observable<FontStyle>

    func insertFontStyles(fontStyles: [FontStyle]) -> Observable<Void>

    func deleteFontStyles(fontStyles: [FontStyle]) -> Observable<Void>

    func deleteAllFontStyles() -> Observable<Void>
    
}
