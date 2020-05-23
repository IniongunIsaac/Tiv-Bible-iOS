//
//  LocalDataSourceDependencyInjections.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 23/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import Swinject
import RealmSwift

struct LocalDataSourceDependencyInjectionGraph {
    
    static func setup(container: Container) {
        
        container.register(IAudioSpeedDataSource.self) { res in AudioSpeedDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IBookDataSource.self) { res in BookDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IBookmarkDataSource.self) { res in BookmarkDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IChapterDataSource.self) { res in ChapterDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IFontStyleDataSource.self) { res in FontStyleDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IHighlightColorDataSource.self) { res in HighlightColorDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IHighlightDataSource.self) { res in HighlightDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IHistoryDataSource.self) { res in HistoryDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(INoteDataSource.self) { res in NoteDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IOtherDataSource.self) { res in OtherDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IRecentSearchDataSource.self) { res in RecentSearchDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(ISettingDataSource.self) { res in SettingDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(ITestamentDataSource.self) { res in TestamentDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IThemeDataSource.self) { res in ThemeDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IVerseDataSource.self) { res in VerseDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
        container.register(IVersionDataSource.self) { res in VersionDataSourceImpl(realm: res.resolve(Realm.self)!) }
        
    }
    
}
