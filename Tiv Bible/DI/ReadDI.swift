//
//  ReadDependencyInjectionGraph.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 27/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

struct ReadDI {
    
    static func setup(container: Container) {
        
        container.register(IReadViewModel.self) { res in
            
            ReadViewModelImpl(bookRepo: res.resolve(IBookRepo.self)!,
                              verseRepo: res.resolve(IVerseRepo.self)!,
                              chapterRepo: res.resolve(IChapterRepo.self)!,
                              preferenceRepo: res.resolve(IPreferenceRepo.self)!,
                              settingsRepo: res.resolve(ISettingRepo.self)!,
                              fontStyleRepo: res.resolve(IFontStyleRepo.self)!,
                              bookmarkRepo: res.resolve(IBookmarkRepo.self)!,
                              highlightColorRepo: res.resolve(IHighlightColorRepo.self)!,
                              highlightRepo: res.resolve(IHighlightRepo.self)!,
                              historyRepo: res.resolve(IHistoryRepo.self)!,
                              noteRepo: res.resolve(INoteRepo.self)!)
        }
        
        container.storyboardInitCompleted(ReadViewController.self) { res, cntrl in
            cntrl.readViewModel = res.resolve(IReadViewModel.self)
        }
        
    }
    
}
