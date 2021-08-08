//
//  BaseBottomPopupViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit
import BottomPopup
import RxSwift
import RxCocoa
import HorizontalProgressBar
import DeviceKit

class BaseBottomPopupViewController: BottomPopupViewController {
    
    public let disposeBag = DisposeBag()
    var progressBar: HorizontalProgressbar?
    
    var views: [UIView] { [] }
    
    var horizontalProgressBarYPosition: CGFloat { 10 }
    
    var progressBarColor: UIColor { .primaryColor }
    
    override var popupHeight: CGFloat { height - 100 }
    
    override var popupTopCornerRadius: CGFloat { 20 }
    
    func getViewModel() -> BaseViewModel {
        preconditionFailure("BaseBottomPopupViewController subclass must provide a subclass of BaseViewModel")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setObservers()
        
        getViewModel().didLoad()
        
        configureViews()
        
    }
    
    func configureViews() {
        setupTapGestures()
    }
    
    func setupTapGestures() {}
    
    fileprivate func createHorizontalProgressBar() {
        progressBar = HorizontalProgressbar(frame: CGRect(x: 0, y: horizontalProgressBarYPosition, width: view.frame.width, height: 4))
        view.addSubview(progressBar!)
        progressBar?.noOfChunks = 1  // You can provide number of Chunks/Strips appearing over the animation. By default it is 3
        progressBar?.kChunkWdith = Double(view.frame.width) - 20 // Adjust the width of Chunks/Strips
        progressBar?.progressTintColor = progressBarColor  // To change the Chunks color
        progressBar?.trackTintColor = UIColor.darkGray  // To change background color of loading indicator
    }
    
    func hideNavigationBar(_ shouldHide: Bool = true) {
        navigationController?.navigationBar.isHidden = shouldHide
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    private func setObservers() {
        observeLoadingState()
        observeErrorState()
        observeAlertMessages()
        setChildViewControllerObservers()
    }
    
    func setChildViewControllerObservers() {}
    
    private func observeAlertMessages() {
        getViewModel().alertMessageOnBottomSheet.asObservable().bind { [weak self] value in
            self?.showAlert(message: value.message, type: value.type)
        }.disposed(by: disposeBag)
    }
    
    private func observeLoadingState() {
        getViewModel().isLoadingOnBottomSheet.asObservable().bind { [weak self] value in
            if value {
                self?.showLoading()
            } else {
                self?.hideLoading()
            }
        }.disposed(by: disposeBag)
    }
    
    private func observeErrorState() {
        getViewModel().errorOnBottomSheet.asObserver().bind { [weak self] error in
            let message = (error as NSError).code == 13 ? "It appears you're offline, please check your internet connection and try again!" : error.localizedDescription
            self?.showAlert(message: message, type: .error)
        }.disposed(by: disposeBag)
    }
    
    func showLoading() {
        enableSwipeBackToPopGesture(false)
        views.disableUserInteraction()
        hideLoading()
        hideAlert()
        createHorizontalProgressBar()
        progressBar?.startAnimating()
        disableNavBar()
    }
    
    func hideLoading() {
        enableSwipeBackToPopGesture()
        views.enableUserInteraction()
        progressBar?.stopAnimating()
        enableNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getViewModel().willAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideAlert()
        getViewModel().willDisappear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideAlert()
        getViewModel().didAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideAlert()
        getViewModel().didDisappear()
    }
    
}
