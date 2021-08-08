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
    
    let isLoadingOnBottomSheet: PublishSubject<Bool> = PublishSubject()
    
    let alertMessageOnBottomSheet: PublishSubject<AlertMessage> = PublishSubject()
    
    let errorOnBottomSheet: PublishSubject<Error> = PublishSubject()
    
    let isLoadingOnDialog: PublishSubject<Bool> = PublishSubject()
    
    let alertMessageOnDialog: PublishSubject<AlertMessage> = PublishSubject()
    
    let errorOnDialog: PublishSubject<Error> = PublishSubject()
    
    func didLoad() { }
    
    func willAppear() { }
    
    func didAppear() { }
    
    func willDisappear() { }
    
    func didDisappear() { }
    
    func emitFalseLoadingAndErrorValues(error: Error, viewControllerType: ViewControllerType = .normal) {
        switch viewControllerType {
        case .normal:
            isLoading.onNext(false)
            self.error.onNext(error)
        case .bottomSheet:
            isLoadingOnBottomSheet.onNext(false)
            errorOnBottomSheet.onNext(error)
        case .dialog:
            isLoadingOnDialog.onNext(false)
            errorOnDialog.onNext(error)
        }
    }
    
    func showLoading(_ shouldShow: Bool = true, viewControllerType: ViewControllerType = .normal) {
        switch viewControllerType {
        case .normal:
            isLoading.onNext(shouldShow)
        case .bottomSheet:
            isLoadingOnBottomSheet.onNext(shouldShow)
        case .dialog:
            isLoadingOnDialog.onNext(shouldShow)
        }
    }
    
    func showMessage(_ message: String, type: AlertType = .success, viewControllerType: ViewControllerType = .normal) {
        switch viewControllerType {
        case .normal:
            alertMessage.onNext(AlertMessage(message: message, type: type))
        case .bottomSheet:
            alertMessageOnBottomSheet.onNext(AlertMessage(message: message, type: type))
        case .dialog:
            alertMessageOnDialog.onNext(AlertMessage(message: message, type: type))
        }
    }
    
    func subscribe<T>(_ observable: Observable<T>, showLoadingAnimation: Bool = true, viewControllerType: ViewControllerType = .normal, showMessageAlerts: Bool = true, errorMessage: String? = nil, success: ((T) -> Void)? = nil, noDataHandler: NoParamHandler? = nil, error: ((Error) -> Void)? = nil) {
        showLoading(showLoadingAnimation, viewControllerType: viewControllerType)
        observable.subscribe(onNext: { [weak self] value in
            self?.showLoading(false, viewControllerType: viewControllerType)
            success?(value)
        }, onError: { [weak self] err in
            self?.showLoading(false, viewControllerType: viewControllerType)
            
            if showMessageAlerts {
                if let errorMessage = errorMessage {
                    self?.showMessage(errorMessage, type: .error, viewControllerType: viewControllerType)
                }
                if let error = error {
                    error(err)
                } else {
                    self?.emitFalseLoadingAndErrorValues(error: err, viewControllerType: viewControllerType)
                }
            }
            
        }).disposed(by: disposeBag)
    }
    
}
