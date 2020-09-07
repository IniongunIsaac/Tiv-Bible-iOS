//
//  SplashViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift
import DeviceKit
import RealmSwift

class SplashViewModel: BaseViewModel, ISplashViewModel {
    
    var preferenceRepo: IPreferenceRepo
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
    var showSetupInProgress: PublishSubject<Bool> = PublishSubject()
    
//    override func didAppear() {
//        super.didAppear()
//        //reset()
//        setupDB()
//    }
    
    fileprivate func reset() {
        let realm = try! Realm()
        debugPrint(realm.configuration.fileURL)
        try! realm.write {
            realm.deleteAll()
            preferenceRepo.isDBInitialized = false
        }
    }
    
    func setupDB() {
        if preferenceRepo.isDBInitialized {
            showSetupInProgress.onNext(false)
            showHome.onNext(true)
        } else {
            initializeDB()
        }
    }
    
    fileprivate func initializeDB() {
        showSetupInProgress.onNext(true)
        showLoading()
        addAppData()
    }
    
    fileprivate func addAppData() {
        
        runOnBackgroundThenMainThread { [weak self] in
            guard let self = self else { return }

            let audioSpeeds = [AudioSpeed(name: "High"), AudioSpeed(name: "Low"), AudioSpeed(name: "Medium")]

            let themes = [Theme(name: "System Default"), Theme(name: "Dark"), Theme(name: "Light")]

            let fontStyles = [FontStyle(name: "Comfortaa"), FontStyle(name: "Happy-Monkey"), FontStyle(name: "Metamorphous"), FontStyle(name: "Roboto"), FontStyle(name: "Montserrat"), FontStyle(name: "Amatic-Sc"), FontStyle(name: "Inconsolata-Expanded"), FontStyle(name: "Indie-Flower"), FontStyle(name: "Jost"), FontStyle(name: "Lato"), FontStyle(name: "Lobster")]

            let highlightColors = AppConstants.colorHexCodes.map { HighlightColor(hexCode: $0) }

            let others = AppConstants.others.map { Other(title: $0.title, subTitle: $0.subTitle, text: $0.content) }

            var fontSize_lineSpacing = (0,0)
            let currDevice = Device.current
            if currDevice.isPhone {
                fontSize_lineSpacing = (14, 8)
            } else if currDevice.isPad {
                fontSize_lineSpacing = (18, 10)
            }

            let settings = [Setting(fontSize: fontSize_lineSpacing.0, lineSpacing: fontSize_lineSpacing.1, fontStyle: fontStyles[0], theme: themes[0], stayAwake: true, audioSpeed: audioSpeeds.last!)]

            let versions = [Version(name: "Old"), Version(name: "New")]
            let testaments = [Testament(name: "Old"), Testament(name: "New")]

            Observable.zip(
                self.audioSpeedRepo.insertAudioSpeeds(audioSpeeds: audioSpeeds),
                self.themeRepo.insertThemes(themes: themes),
                self.fontStyleRepo.insertFontStyles(fontStyles: fontStyles),
                self.highlightColorRepo.insertHighlightColors(highlightColors: highlightColors),
                self.otherRepo.insertOthers(others: others),
                self.settingsRepo.insertSettings(settings: settings),
                self.versionRepo.insertVersions(versions: versions),
                self.testamentRepo.insertTestaments(testaments: testaments))
                .subscribe(onNext: { [weak self] _, _, _, _, _, _, _, _ in
                    self?.saveBooksAndChaptersAndVerses(testaments, versions[0])
                    }, onError: { [weak self] error in
                        self?.emitFalseLoadingAndErrorValues(error: error)
                }).disposed(by: self.disposeBag)

        }
        
    }
    
    fileprivate func saveBooksAndChaptersAndVerses(_ testaments: [Testament], _ version: Version) {
        let tivBibleData = try! JSONDecoder().decode([TivBibleData].self, from: Data(contentsOf: Bundle.main.url(forResource: "tivBibleData", withExtension: "json")!))
        Observable.just(tivBibleData).subscribe(onNext: { [weak self] bibleData in
            
            guard let self = self else { return }
            
            let bibleBooks = bibleData.distinctBy { $0.book }.sorted { $0.orderNo < $1.orderNo }
            
            bibleBooks.forEach { bibleBook in
                
                //get all occurrences of bibleBook
                let bookOccurrences = bibleData.filter { $0.book == bibleBook.book }
                
                //Get number of verses for book
                let numOfBookVerses = bookOccurrences.count

                //get book chapters
                let bookChapters = bookOccurrences.distinctBy { $0.chapter }

                //get number of chapters for book
                let numOfChapters = bookChapters.count
                
                //get book testament
                let testament = bibleBook.testament.lowercased() == "old" ? testaments[0] : testaments[1]
                
                //create book object for saving into the database
                let book = Book(
                    name: bibleBook.book.lowercased().capitalized,
                    orderNo: bibleBook.orderNo,
                    numberOfChapters: numOfChapters,
                    numberOfVerses: numOfBookVerses,
                    testament: testament,
                    version: version
                )
                
                //create chapters list for saving into the database
                var chapters = [Chapter]()

                //create verses list for saving into the database
                var verses = [Verse]()
                
                bookChapters.forEach { bookChapter in
                    
                    let bookChapterVerses = bookOccurrences.filter { $0.chapter == bookChapter.chapter }.distinctBy { $0.verse }
                    
                    //get number of book's chapter's verses
                    let numOfBookChapterVerses = bookChapterVerses.count
                    
                    //create and add chapter to chapters list
                    let chapter = Chapter(chapterNumber: bookChapter.chapter, numberOfVerses: numOfBookChapterVerses)
                    chapters.append(chapter)
                    
                    //create verses
                    let versesList = bookChapterVerses.map { Verse(number: $0.verse, text: $0.text.components(separatedBy: .whitespacesAndNewlines).joined(separator: " "), hasTitle: !$0.title.isEmpty, title: $0.title.components(separatedBy: .whitespacesAndNewlines).joined(separator: " ")) }
                    
                    //attach verses to chapter
                    chapter.verses.append(objectsIn: versesList)
                    
                    //add verses to verses list
                    verses.append(contentsOf: versesList)
                    
                }
                
                //attach chapters to book
                book.chapters.append(objectsIn: chapters)
                
                //save book, chapters and verses
                Observable.zip(
                    self.bookRepo.insertBooks(books: [book]),
                    self.chapterRepo.insertChapters(chapters: chapters),
                    self.verseRepo.insertVerses(verses: verses))
                .subscribe(onNext: { _, _, _ in
                    debugPrint("Added book, chapters and verses sequence...")
                }, onError: { [weak self] error in
                    self?.emitFalseLoadingAndErrorValues(error: error)
                }).disposed(by: self.disposeBag)
                
            }
            
            //save boolean indicating that db has been setup
            self.preferenceRepo.isDBInitialized = true
            self.showLoading(false)
            self.showSetupInProgress.onNext(false)
            
            self.showHome.onNext(true)
            
        }, onError: { [weak self] error in
            self?.emitFalseLoadingAndErrorValues(error: error)
        }).disposed(by: disposeBag)
    }
}
