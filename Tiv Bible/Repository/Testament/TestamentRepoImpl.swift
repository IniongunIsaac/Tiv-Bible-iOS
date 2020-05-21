//
//  TestamentRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct TestamentRepoImpl: ITestamentRepo {
    
    let testamentDataSource: ITestamentDataSource
    
    func getAllTestaments() -> Observable<[Testament]> {
        testamentDataSource.getAllTestaments()
    }
    
    func getTestamentById(testamentId: String) -> Observable<Testament> {
        testamentDataSource.getTestamentById(testamentId: testamentId)
    }
    
    func getTestamentByName(testamentName: String) -> Observable<Testament> {
        testamentDataSource.getTestamentByName(testamentName: testamentName)
    }
    
    func insertTestaments(testaments: [Testament]) -> Observable<Void> {
        testamentDataSource.insertTestaments(testaments: testaments)
    }
    
    func deleteTestaments(testaments: [Testament]) -> Observable<Void> {
        testamentDataSource.deleteTestaments(testaments: testaments)
    }
    
    func deleteAllTestaments() -> Observable<Void> {
        testamentDataSource.deleteAllTestaments()
    }
    
}
