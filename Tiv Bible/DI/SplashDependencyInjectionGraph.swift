//
//  SplashDependencyInjectionGraph.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 25/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

struct SplashDependencyInjectionGraph {
    
    static func setup(container: Container) {
        
        container.register(ISplashViewModel.self) { res in
            
            SplashViewModel(preferenceRepo: res.resolve(IPreferenceRepo.self)!,
                            versionRepo: res.resolve(IVersionRepo.self)!,
                            testamentRepo: res.resolve(ITestamentRepo.self)!,
                            bookRepo: res.resolve(IBookRepo.self)!,
                            chapterRepo: res.resolve(IChapterRepo.self)!,
                            verseRepo: res.resolve(IVerseRepo.self)!,
                            audioSpeedRepo: res.resolve(IAudioSpeedRepo.self)!,
                            fontStyleRepo: res.resolve(IFontStyleRepo.self)!,
                            settingsRepo: res.resolve(ISettingRepo.self)!,
                            highlightColorRepo: res.resolve(IHighlightColorRepo.self)!,
                            otherRepo: res.resolve(IOtherRepo.self)!)
        }
        
        container.storyboardInitCompleted(SplashViewController.self) { res, cntrl in
            cntrl.splashViewModel = res.resolve(ISplashViewModel.self)
        }
        
    }
    
}
