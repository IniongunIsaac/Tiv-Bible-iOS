//
//  IHighlightDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IHighlightDataSource {
    
    func getAllHighlights() -> Observable<[Highlight]>

    func getHighlightById(id: String) -> Observable<Highlight>
    
    func getHighlightsByChapter(_ chapterId: String) -> Observable<[Highlight]>

    func getHighlightsByDate(highlightedOn: Date) -> Observable<[Highlight]>

    func insertHighlights(highlights: [Highlight]) -> Observable<Void>

    func deleteHighlights(highlights: [Highlight]) -> Observable<Void>

    func deleteAllHighlights() -> Observable<Void>
    
}
