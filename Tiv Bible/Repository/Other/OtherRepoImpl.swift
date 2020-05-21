//
//  OtherRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct OtherRepoImpl: IOtherRepo {
    
    let otherDataSource: IOtherDataSource
    
    func getAllOthers() -> Observable<[Other]> {
        otherDataSource.getAllOthers()
    }
    
    func getOtherById(otherId: String) -> Observable<Other> {
        otherDataSource.getOtherById(otherId: otherId)
    }
    
    func getOtherByText(searchText: String) -> Observable<Other> {
        otherDataSource.getOtherByText(searchText: searchText)
    }
    
    func insertOthers(others: [Other]) -> Observable<Void> {
        otherDataSource.insertOthers(others: others)
    }
    
    func deleteOthers(others: [Other]) -> Observable<Void> {
        otherDataSource.deleteOthers(others: others)
    }
    
    func deleteAllOthers() -> Observable<Void> {
        otherDataSource.deleteAllOthers()
    }
    
}
