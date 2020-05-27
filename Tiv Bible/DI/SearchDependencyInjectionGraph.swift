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

struct SearchDependencyInjectionGraph {
    
    static func setup(container: Container) {
        
        container.register(ISearchViewModel.self) { res in
            
            SearchViewModelImpl()
        }
        
        container.storyboardInitCompleted(SearchViewController.self) { res, cntrl in
            cntrl.searchViewModel = res.resolve(ISearchViewModel.self)
        }
        
    }
    
}
