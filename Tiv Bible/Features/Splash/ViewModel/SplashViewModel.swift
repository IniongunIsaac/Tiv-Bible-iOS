//
//  SplashViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

class SplashViewModel: BaseViewModel, ISplashViewModel {
    
    let preferenceRepo: IPreferenceRepo
    let versionRepo: IVersionRepo
    let testamentRepo: ITestamentRepo
    let bookRepo: IBookRepo
    let chapterRepo: IChapterRepo
    let verseRepo: IVerseRepo
    let audioSpeedRepo: IAudioSpeedRepo
    let themeRepo: IThemeRepo
    let fontStyleRepo: IFontStyleRepo
    let settingsRepo: ISettingRepo
    let highlightColorRepo: IHighlightColorRepo
    let otherRepo: IOtherRepo
    
    init(preferenceRepo: IPreferenceRepo, versionRepo: IVersionRepo,testamentRepo: ITestamentRepo, bookRepo: IBookRepo, chapterRepo: IChapterRepo, verseRepo: IVerseRepo, audioSpeedRepo: IAudioSpeedRepo, themeRepo: IThemeRepo, fontStyleRepo: IFontStyleRepo, settingsRepo: ISettingRepo, highlightColorRepo: IHighlightColorRepo, otherRepo: IOtherRepo) {
        
        self.preferenceRepo = preferenceRepo
        self.versionRepo = versionRepo
        self.testamentRepo = testamentRepo
        self.bookRepo = bookRepo
        self.chapterRepo = chapterRepo
        self.verseRepo = verseRepo
        self.audioSpeedRepo = audioSpeedRepo
        self.themeRepo = themeRepo
        self.fontStyleRepo = fontStyleRepo
        self.settingsRepo = settingsRepo
        self.highlightColorRepo = highlightColorRepo
        self.otherRepo = otherRepo
    }
    
    var showHome: PublishSubject<Bool> = PublishSubject()
    
    override func didLoad() {
        super.didLoad()
        setupDB()
    }
    
    fileprivate func setupDB() {
        if preferenceRepo.isDBInitialized {
            showHome.onNext(true)
        } else {
            initializeDB()
        }
    }
    
    fileprivate func initializeDB() {
        showLoading()
        addFontStylesAndThemesAndAudioSpeeds()
    }
    
    fileprivate func addFontStylesAndThemesAndAudioSpeeds() {
        
    }
    
}
