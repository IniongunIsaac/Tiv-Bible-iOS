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
        
        container.register(IMoreViewModel.self) { res in
            
            MoreViewModelImpl()
        }
        
        container.storyboardInitCompleted(MoreViewController.self) { res, cntrl in
            cntrl.moreViewModel = res.resolve(IMoreViewModel.self)
        }
        
    }
    
}
