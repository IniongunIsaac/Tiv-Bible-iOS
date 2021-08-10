//
//  SearchDependencyInjectionGraph.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 27/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

struct SearchDI {
    
    static func setup(container: Container) {
        
        container.register(ISearchViewModel.self) { res in
            SearchViewModelImpl(booksRepo: res.resolve(IBookRepo.self)!, chaptersRepo: res.resolve(IChapterRepo.self)!, preferenceRepo: res.resolve(IPreferenceRepo.self)!, versesRepo: res.resolve(IVerseRepo.self)!, historyRepo: res.resolve(IHistoryRepo.self)!)
        }
        
        container.storyboardInitCompleted(SearchViewController.self) { res, cntrl in
            cntrl.searchViewModel = res.resolve(ISearchViewModel.self)
        }
        
    }
    
}
