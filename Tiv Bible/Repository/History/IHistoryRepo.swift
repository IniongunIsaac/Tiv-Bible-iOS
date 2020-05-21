//
//  IHistoryRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IHistoryRepo {
    
    func getAllHistory() -> Observable<[History]>

    func getHistoryById(historyId: String) -> Observable<History>

    func insertHistory(history: [History]) -> Observable<Void>

    func deleteHistory(history: [History]) -> Observable<Void>

    func deleteAllHistory() -> Observable<Void>
    
}
