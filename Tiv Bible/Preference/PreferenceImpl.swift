//
//  PreferenceImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 22/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

struct PreferenceImpl: IPreference {
    
    fileprivate let userDefs = UserDefaults.standard
    
    init(){}
    
    var isDBInitialized: Bool {
        get {
            return userDefs.bool(forKey: PreferenceConstants.DB_INITIALIZED_KEY)
        }
        
        set {
            userDefs.set(newValue, forKey: PreferenceConstants.DB_INITIALIZED_KEY)
        }
    }
    
    var currentTheme: String {
        get {
            return userDefs.string(forKey: PreferenceConstants.CURRENT_THEME_KEY) ?? ""
        }
        
        set {
            userDefs.set(newValue, forKey: PreferenceConstants.CURRENT_THEME_KEY)
        }
    }
    
    var currentVerseId: String {
        get {
            return userDefs.string(forKey: PreferenceConstants.CURRENT_VERSE_KEY) ?? ""
        }
        
        set {
            userDefs.set(newValue, forKey: PreferenceConstants.CURRENT_VERSE_KEY)
        }
    }
    
    var currentChapterId: String {
        get {
            
            return userDefs.string(forKey: PreferenceConstants.CURRENT_CHAPTER_KEY) ?? ""
        }
        
        set {
            userDefs.set(newValue, forKey: PreferenceConstants.CURRENT_CHAPTER_KEY)
        }
    }
    
    var currentBookId: String {
        get {
            return userDefs.string(forKey: PreferenceConstants.CURRENT_BOOK_KEY) ?? ""
        }
        
        set {
            userDefs.set(newValue, forKey: PreferenceConstants.CURRENT_BOOK_KEY)
        }
    }
    
    var currentVerseString: String {
        get {
            return userDefs.string(forKey: PreferenceConstants.CURRENT_VERSE_KEY) ?? ""
        }
        
        set {
            userDefs.set(newValue, forKey: PreferenceConstants.CURRENT_VERSE_KEY)
        }
    }
    
    var shouldReloadVerses: Bool {
        get {
            return userDefs.bool(forKey: PreferenceConstants.SHOULD_RELOAD_VERSES_KEY)
        }
        
        set {
            userDefs.set(newValue, forKey: PreferenceConstants.SHOULD_RELOAD_VERSES_KEY)
        }
    }
    
}
