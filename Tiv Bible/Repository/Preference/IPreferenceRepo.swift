//
//  IPreferenceRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 23/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

protocol IPreferenceRepo: Scopable {
    
    var isDBInitialized: Bool { get set }

    var currentTheme: Theme { get set }

    var currentVerseId: String { get set }

    var currentChapterId: String { get set }

    var currentBookId: String { get set }

    var currentVerseString: String { get set }

    var shouldReloadVerses: Bool { get set }
    
    var selectedVerseNumber: Int { get set }
    
    var shouldScrollToVerse: Bool { get set }
    
    var stayAwake: Bool { get set }
    
}
