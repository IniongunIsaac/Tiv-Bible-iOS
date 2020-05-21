//
//  HighlightRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct HighlightRepoImpl: IHighlightRepo {
    
    let highlightDataSource: IHighlightDataSource
    
    func getAllHighlights() -> Observable<[Highlight]> {
        highlightDataSource.getAllHighlights()
    }
    
    func getHighlightById(id: String) -> Observable<Highlight> {
        highlightDataSource.getHighlightById(id: id)
    }
    
    func getHighlightsByDate(highlightedOn: Date) -> Observable<[Highlight]> {
        highlightDataSource.getHighlightsByDate(highlightedOn: highlightedOn)
    }
    
    func insertHighlights(highlights: [Highlight]) -> Observable<Void> {
        highlightDataSource.insertHighlights(highlights: highlights)
    }
    
    func deleteHighlights(highlights: [Highlight]) -> Observable<Void> {
        highlightDataSource.deleteHighlights(highlights: highlights)
    }
    
    func deleteAllHighlights() -> Observable<Void> {
        highlightDataSource.deleteAllHighlights()
    }
    
}
