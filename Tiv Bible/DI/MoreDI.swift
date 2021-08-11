//
//  MoreDependencyInjectionGraph.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 27/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

struct MoreDI {
    
    static func setup(container: Container) {
        
        container.register(IMoreViewModel.self) {
            MoreViewModelImpl(bookmarksRepo: $0.resolve(IBookmarkRepo.self)!, notesRepo: $0.resolve(INoteRepo.self)!, highlightsRepo: $0.resolve(IHighlightRepo.self)!, historyRepo: $0.resolve(IHistoryRepo.self)!, settingsRepo: $0.resolve(ISettingRepo.self)!, othersRepo: $0.resolve(IOtherRepo.self)!, preferenceRepo: $0.resolve(IPreferenceRepo.self)!)
        }
        
        container.storyboardInitCompleted(MoreViewController.self) { res, cntrl in
            cntrl.moreViewModel = res.resolve(IMoreViewModel.self)
        }
        
        container.storyboardInitCompleted(BookmarksViewController.self) { res, cntrl in
            cntrl.moreViewModel = res.resolve(IMoreViewModel.self)
        }
        
        container.storyboardInitCompleted(HighlightsViewController.self) { res, cntrl in
            cntrl.moreViewModel = res.resolve(IMoreViewModel.self)
        }
        
        container.storyboardInitCompleted(NotesViewController.self) { res, cntrl in
            cntrl.moreViewModel = res.resolve(IMoreViewModel.self)
        }
        
        container.storyboardInitCompleted(HistoryViewController.self) { res, cntrl in
            cntrl.moreViewModel = res.resolve(IMoreViewModel.self)
        }
        
    }
    
}
