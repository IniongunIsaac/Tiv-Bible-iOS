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
        showLoading(false)
        self.error.onNext(error)
    }
    
    func showLoading(_ shouldShow: Bool = true) {
        isLoading.onNext(shouldShow)
    }
    
    func showMessage(_ message: String, type: AlertType = .success) {
        alertMessage.onNext(AlertMessage(message: message, type: type))
    }
    
    func subscribe<T>(_ observable: Observable<T>, success: @escaping (T) -> Void, error: ((Error) -> Void)? = nil) {
        observable.subscribe(onNext: { value in
            success(value)
        }, onError: { [weak self] err in
            error?(err)
            self?.emitFalseLoadingAndErrorValues(error: err)
        }).disposed(by: disposeBag)
    }
}
