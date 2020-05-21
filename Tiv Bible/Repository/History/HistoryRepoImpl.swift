//
//  HistoryRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct HistoryRepoImpl: IHistoryRepo {
    
    let historyDataSource: IHistoryDataSource
    
    func getAllHistory() -> Observable<[History]> {
        historyDataSource.getAllHistory()
    }
    
    func getHistoryById(historyId: String) -> Observable<History> {
        historyDataSource.getHistoryById(historyId: historyId)
    }
    
    func insertHistory(history: [History]) -> Observable<Void> {
        historyDataSource.insertHistory(history: history)
    }
    
    func deleteHistory(history: [History]) -> Observable<Void> {
        historyDataSource.deleteHistory(history: history)
    }
    
    func deleteAllHistory() -> Observable<Void> {
        historyDataSource.deleteAllHistory()
    }
    
}
