//
//  IHighlightColorRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IHighlightColorRepo {
    
    func getAllHighlightColors() -> Observable<[HighlightColor]>

    func getHighlightColorById(highlightColorId: String) -> Observable<HighlightColor>

    func insertHighlightColors(highlightColors: [HighlightColor]) -> Observable<Void>

    func deleteHighlightColors(highlightColors: [HighlightColor]) -> Observable<Void>

    func deleteAllHighlightColors() -> Observable<Void>
    
}
