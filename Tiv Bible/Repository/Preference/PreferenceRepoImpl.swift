//
//  PreferenceRepoImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 23/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

struct PreferenceRepoImpl: IPreferenceRepo {
    
    var preference: IPreference
    
    var isDBInitialized: Bool {
        get { preference.isDBInitialized }
        set { preference.isDBInitialized = newValue }
    }
    
    var currentTheme: Theme {
        get { preference.currentTheme }
        set { preference.currentTheme = newValue }
    }
    
    var currentVerseId: String {
        get { preference.currentVerseId }
        set { preference.currentVerseId = newValue }
    }
    
    var currentChapterId: String {
        get { preference.currentChapterId }
        set { preference.currentChapterId = newValue }
    }
    
    var currentBookId: String {
        get { preference.currentBookId }
        set { preference.currentBookId = newValue }
    }
    
    var currentVerseString: String {
        get { preference.currentVerseString }
        set { preference.currentVerseString = newValue }
    }
    
    var shouldReloadVerses: Bool {
        get { preference.shouldReloadVerses }
        set { preference.shouldReloadVerses = newValue }
    }
    
    var selectedVerseNumber: Int {
        get { preference.selectedVerseNumber }
        set { preference.selectedVerseNumber = newValue }
    }
    
    var shouldScrollToVerse: Bool {
        get { preference.shouldScrollToVerse }
        set { preference.shouldScrollToVerse = newValue }
    }
    
}
