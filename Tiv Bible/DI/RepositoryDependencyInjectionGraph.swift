//
//  RepositoryDependencyInjectionGraph.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 23/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import Swinject

struct RepositoryDependencyInjectionGraph {
    
    static func setup(container: Container) {
        
        container.register(IPreferenceRepo.self) { res in PreferenceRepoImpl(preference: res.resolve(IPreference.self)!) }
        
        container.register(IAudioSpeedRepo.self) { res in AudioSpeedRepoImpl(audioSpeedDataSource: res.resolve(IAudioSpeedDataSource.self)!) }
        
        container.register(IBookRepo.self) { res in BookRepoImpl(bookDataSource: res.resolve(IBookDataSource.self)!) }
        
        container.register(IBookmarkRepo.self) { res in BookmarkRepoImpl(bookmarksDataSource: res.resolve(IBookmarkDataSource.self)!) }
        
        container.register(IChapterRepo.self) { res in ChapterRepoImpl(chapterDataSource: res.resolve(IChapterDataSource.self)!) }
        
        container.register(IFontStyleRepo.self) { res in FontStyleRepoImpl(fontStyleDataSource: res.resolve(IFontStyleDataSource.self)!) }
        
        container.register(IHighlightColorRepo.self) { res in HighlightColorRepoImpl(highlightColorDataSource: res.resolve(IHighlightColorDataSource.self)!) }
        
        container.register(IHighlightRepo.self) { res in HighlightRepoImpl(highlightDataSource: res.resolve(IHighlightDataSource.self)!) }
        
        container.register(IHistoryRepo.self) { res in HistoryRepoImpl(historyDataSource: res.resolve(IHistoryDataSource.self)!) }
        
        container.register(INoteRepo.self) { res in NoteRepoImpl(noteDataSource: res.resolve(INoteDataSource.self)!) }
        
        container.register(IOtherRepo.self) { res in OtherRepoImpl(otherDataSource: res.resolve(IOtherDataSource.self)!) }
        
        container.register(IRecentSearchRepo.self) { res in RecentSearchRepoImpl(recentSearchDataSource: res.resolve(IRecentSearchDataSource.self)!) }
        
        container.register(ISettingRepo.self) { res in SettingRepoImpl(settingsDataSource: res.resolve(ISettingDataSource.self)!) }
        
        container.register(ITestamentRepo.self) { res in TestamentRepoImpl(testamentDataSource: res.resolve(ITestamentDataSource.self)!) }
        
        container.register(IThemeRepo.self) { res in ThemeRepoImpl(themeDataSource: res.resolve(IThemeDataSource.self)!) }
        
        container.register(IVerseRepo.self) { res in VerseRepoImpl(verseDataSource: res.resolve(IVerseDataSource.self)!) }
        
        container.register(IVersionRepo.self) { res in VersionRepoImpl(versionDataSource: res.resolve(IVersionDataSource.self)!) }
        
    }
    
}
