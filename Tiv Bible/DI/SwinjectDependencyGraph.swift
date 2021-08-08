//
//  SwinjectDependencyGraph.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 23/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import RealmSwift

extension SwinjectStoryboard {
    
    public static func setup() {
        
        runRealmMigrations()
        
        defaultContainer.register(Realm.self) { _ in try! Realm() }
        
        defaultContainer.register(IPreference.self) { _ in PreferenceImpl() }
        
        defaultContainer.register(IPreferenceRepo.self) { res in PreferenceRepoImpl(preference: res.resolve(IPreference.self)!) }
        
        LocalDataSourceDependencyInjectionGraph.setup(container: defaultContainer)
        
        RepositoryDependencyInjectionGraph.setup(container: defaultContainer)
        
        SplashDependencyInjectionGraph.setup(container: defaultContainer)
        
        ReadDependencyInjectionGraph.setup(container: defaultContainer)
        
        SearchDependencyInjectionGraph.setup(container: defaultContainer)
        
        MoreDependencyInjectionGraph.setup(container: defaultContainer)
        
        ReferencesDI.setup(container: defaultContainer)
        
    }
    
    fileprivate static func runRealmMigrations() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 0) {
                    
                }
            })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
}
