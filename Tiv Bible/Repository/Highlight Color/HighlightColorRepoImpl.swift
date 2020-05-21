//
//  HighlightColorRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct HighlightColorRepoImpl: IHighlightColorRepo {
    
    let highlightColorDataSource: IHighlightColorDataSource
    
    func getAllHighlightColors() -> Observable<[HighlightColor]> {
        highlightColorDataSource.getAllHighlightColors()
    }
    
    func getHighlightColorById(highlightColorId: String) -> Observable<HighlightColor> {
        highlightColorDataSource.getHighlightColorById(highlightColorId: highlightColorId)
    }
    
    func insertHighlightColors(highlightColors: [HighlightColor]) -> Observable<Void> {
        highlightColorDataSource.insertHighlightColors(highlightColors: highlightColors)
    }
    
    func deleteHighlightColors(highlightColors: [HighlightColor]) -> Observable<Void> {
        highlightColorDataSource.deleteHighlightColors(highlightColors: highlightColors)
    }
    
    func deleteAllHighlightColors() -> Observable<Void> {
        highlightColorDataSource.deleteAllHighlightColors()
    }
    
}
