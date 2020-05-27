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
        
        defaultContainer.register(Realm.self) { _ in try! Realm() }
        
        defaultContainer.register(IPreference.self) { _ in PreferenceImpl() }
        
        defaultContainer.register(IPreferenceRepo.self) { res in PreferenceRepoImpl(preference: res.resolve(IPreference.self)!) }
        
        LocalDataSourceDependencyInjectionGraph.setup(container: defaultContainer)
        
        RepositoryDependencyInjectionGraph.setup(container: defaultContainer)
        
        SplashDependencyInjectionGraph.setup(container: defaultContainer)
        
        ReadDependencyInjectionGraph.setup(container: defaultContainer)
        
        SearchDependencyInjectionGraph.setup(container: defaultContainer)
        
        MoreDependencyInjectionGraph.setup(container: defaultContainer)
        
    }
    
}
