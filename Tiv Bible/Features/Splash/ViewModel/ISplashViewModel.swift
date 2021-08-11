//
//  ISplashViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ISplashViewModel {
    
    var showHome: PublishSubject<Bool> { get }
    
    var showSetupInProgress: PublishSubject<Bool> { get }
    
    func setupDB()
}
