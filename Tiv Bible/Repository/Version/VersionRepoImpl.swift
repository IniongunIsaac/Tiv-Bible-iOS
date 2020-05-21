//
//  VersionRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 21/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

struct VersionRepoImpl: IVersionRepo {
    
    let versionDataSource: IVersionDataSource
    
    func getAllVersions() -> Observable<[Version]> {
        versionDataSource.getAllVersions()
    }
    
    func getVersionById(versionId: String) -> Observable<Version> {
        versionDataSource.getVersionById(versionId: versionId)
    }
    
    func getVersionByName(versionName: String) -> Observable<Version> {
        versionDataSource.getVersionByName(versionName: versionName)
    }
    
    func insertVersions(versions: [Version]) -> Observable<Void> {
        versionDataSource.insertVersions(versions: versions)
    }
    
    func deleteVersions(versions: [Version]) -> Observable<Void> {
        versionDataSource.deleteVersions(versions: versions)
    }
    
    func deleteAllVersions() -> Observable<Void> {
        versionDataSource.deleteAllVersions()
    }
    
}
