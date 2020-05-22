//
//  IPreference.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 22/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

protocol IPreference {
    
    var isDBInitialized: Bool { get set }

    var currentTheme: String { get set }

    var currentVerseId: String { get set }

    var currentChapterId: String { get set }

    var currentBookId: String { get set }

    var currentVerseString: String { get set }

    var shouldReloadVerses: Bool { get set }
    
}
