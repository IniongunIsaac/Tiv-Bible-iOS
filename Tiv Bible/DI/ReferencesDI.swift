//
//  ReferencesDI.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

struct ReferencesDI {
    
    static func setup(container: Container) {
        
        container.register(IReferenceViewModel.self) {
            ReferenceViewModelImpl(booksRepo: $0.resolve(IBookRepo.self)!, chaptersRepo: $0.resolve(IChapterRepo.self)!, versesRepo: $0.resolve(IVerseRepo.self)!, historyRepo: $0.resolve(IHistoryRepo.self)!, preferenceRepo: $0.resolve(IPreferenceRepo.self)!)
        }
        
        container.storyboardInitCompleted(ReferencesViewController.self) { res, cntrl in
            cntrl.referencesViewModel = res.resolve(IReferenceViewModel.self)
        }
        
    }
    
}
