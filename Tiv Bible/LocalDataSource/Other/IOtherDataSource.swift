//
//  IOtherDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IOtherDataSource {
    
    func getAllOthers() -> Observable<[Other]>

    func getOtherById(otherId: String) -> Observable<Other>

    //@Query("select * from Other where title like '%' || :searchText || '%' limit 1")
    func getOtherByText(searchText: String) -> Observable<Other>

    func insertOthers(others: [Other]) -> Observable<Void>

    func deleteOthers(others: [Other]) -> Observable<Void>

    func deleteAllOthers() -> Observable<Void>
    
}
