//
//  PreferenceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 22/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

struct PreferenceImpl: IPreference {
    
    fileprivate let remoteConfig = RemoteConfig.remoteConfig()
    
    @UserDefaultStorage(key: PreferenceConstants.DB_INITIALIZED_KEY, default: false)
    var isDBInitialized: Bool
    
    @UserDefaultStorage(key: PreferenceConstants.CURRENT_THEME, default: .system)
    var currentTheme: Theme
    
    @UserDefaultStorage(key: PreferenceConstants.CURRENT_VERSE_KEY, default: "")
    var currentVerseId: String
    
    @UserDefaultStorage(key: PreferenceConstants.CURRENT_CHAPTER_KEY, default: "")
    var currentChapterId: String
    
    @UserDefaultStorage(key: PreferenceConstants.CURRENT_BOOK_KEY, default: "")
    var currentBookId: String
    
    @UserDefaultStorage(key: PreferenceConstants.CURRENT_VERSE_KEY, default: "")
    var currentVerseString: String
    
    @UserDefaultStorage(key: PreferenceConstants.SHOULD_RELOAD_VERSES_KEY, default: false)
    var shouldReloadVerses: Bool
    
    @UserDefaultStorage(key: PreferenceConstants.SELECTED_VERSE_NUMBER, default: 0)
    var selectedVerseNumber: Int
    
    @UserDefaultStorage(key: PreferenceConstants.SHOULD_SCROLL_TO_VERSE, default: false)
    var shouldScrollToVerse: Bool
    
    @UserDefaultStorage(key: PreferenceConstants.STAY_AWAKE, default: false)
    var stayAwake: Bool
    
    var appVersion: String { remoteConfig.configValue(forKey: PreferenceConstants.APP_VERSION).stringValue! }
    
}
