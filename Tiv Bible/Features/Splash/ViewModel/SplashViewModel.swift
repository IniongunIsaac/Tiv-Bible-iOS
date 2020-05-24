//
//  SplashViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation

class SplashViewModel: BaseViewModel {
    
    func start() {
        isLoading.onNext(true)
    }
    
    func stop() {
        isLoading.onNext(false)
    }
    
}
