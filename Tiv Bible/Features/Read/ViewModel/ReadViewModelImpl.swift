//
//  ReadViewModelImpl.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

class ReadViewModelImpl: BaseViewModel, IReadViewModel {
    
    let bookRepo: IBookRepo
    let verseRepo: IVerseRepo
    let chapterRepo: IChapterRepo
    var preferenceRepo: IPreferenceRepo
    let settingsRepo: ISettingRepo
    let fontStyleRepo: IFontStyleRepo
    let themeRepo: IThemeRepo
    let bookmarkRepo: IBookmarkRepo
    let highlightColorRepo: IHighlightColorRepo
    let highlightRepo: IHighlightRepo
    let historyRepo: IHistoryRepo
    let noteRepo: INoteRepo
    
    init(bookRepo: IBookRepo, verseRepo: IVerseRepo, chapterRepo: IChapterRepo, preferenceRepo: IPreferenceRepo, settingsRepo: ISettingRepo, fontStyleRepo: IFontStyleRepo, themeRepo: IThemeRepo, bookmarkRepo: IBookmarkRepo, highlightColorRepo: IHighlightColorRepo, highlightRepo: IHighlightRepo, historyRepo: IHistoryRepo, noteRepo: INoteRepo) {
        self.bookRepo = bookRepo
        self.verseRepo = verseRepo
        self.chapterRepo = chapterRepo
        self.preferenceRepo = preferenceRepo
        self.settingsRepo = settingsRepo
        self.fontStyleRepo = fontStyleRepo
        self.themeRepo = themeRepo
        self.bookmarkRepo = bookmarkRepo
        self.highlightColorRepo = highlightColorRepo
        self.highlightRepo = highlightRepo
        self.historyRepo = historyRepo
        self.noteRepo = noteRepo
    }
    
    var currentSettings: PublishSubject<Setting> = PublishSubject()
    
    override func didAppear() {
        super.didAppear()
        getUserSettings()
        self.preferenceRepo.shouldReloadVerses = true
    }
    
    fileprivate func getUserSettings() {
        showLoading()
        runOnBackgroundThenMainThread { [weak self] in
            guard let self = self else { return }
            self.subscribe(self.settingsRepo.getAllSetting(), success: { setting in
                self.currentSettings.onNext(setting)
                self.showLoading(false)
            })
        }
    }
    
    func getBookFromSavedPreferencesOrInitializeWithGenese() {
        if preferenceRepo.shouldReloadVerses {
            preferenceRepo.shouldReloadVerses = false
            
            if preferenceRepo.currentBookId.isEmpty {
                
            } else {
                
            }
            
        }
    }
    
}
