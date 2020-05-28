//
//  IReadViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol IReadViewModel {
    
    var currentSettings: PublishSubject<Setting> { get }
    
    var bookNameAndChapterNumber: PublishSubject<String> { get }
    
    var currentVerses: PublishSubject<[Verse]> { get }
    
    func getBookFromSavedPreferencesOrInitializeWithGenese()
    
}
