//
//  BaseViewModel.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    let isLoading: PublishSubject<Bool> = PublishSubject()
    
    let alertMessage: PublishSubject<AlertMessage> = PublishSubject()
    
    let error: PublishSubject<Error> = PublishSubject()
    
    func didLoad() { }
    
    func willAppear() { }
    
    func didAppear() { }
    
    func willDisappear() { }
    
    func didDisappear() { }
    
    func emitFalseLoadingAndErrorValues(error: Error) {
        isLoading.onNext(false)
        self.error.onNext(error)
    }
    
    func showLoading(_ shouldShow: Bool = true) {
        isLoading.onNext(shouldShow)
    }
    
}
