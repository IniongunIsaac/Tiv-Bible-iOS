//
//  IPreferenceRepo.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 23/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

protocol IPreferenceRepo {
    
    var isDBInitialized: Bool { get set }

    var currentTheme: ThemeType { get set }

    var currentVerseId: String { get set }

    var currentChapterId: String { get set }

    var currentBookId: String { get set }

    var currentVerseString: String { get set }

    var shouldReloadVerses: Bool { get set }
    
}
