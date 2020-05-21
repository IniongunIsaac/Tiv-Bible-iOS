//
//  ITestamentRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol ITestamentRepo {
    
    func getAllTestaments() -> Observable<[Testament]>

    func getTestamentById(testamentId: String) -> Observable<Testament>

    func getTestamentByName(testamentName: String) -> Observable<Testament>

    func insertTestaments(testaments: [Testament]) -> Observable<Void>

    func deleteTestaments(testaments: [Testament]) -> Observable<Void>

    func deleteAllTestaments() -> Observable<Void>
    
}
