//
//  IVersionDataSource.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

protocol IVersionDataSource {
    
    func getAllVersions() -> Observable<[Version]>

    func getVersionById(versionId: String) -> Observable<Version>

    func getVersionByName(versionName: String) -> Observable<Version>

    func insertVersions(versions: [Version]) -> Observable<Void>

    func deleteVersions(versions: [Version]) -> Observable<Void>

    func deleteAllVersions() -> Observable<Void>
    
}
