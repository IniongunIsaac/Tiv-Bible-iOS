//
//  BaseViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import HorizontalProgressBar

class BaseViewController: UIViewController {
    
    public let disposeBag = DisposeBag()
    fileprivate var alert: CustomAlert?
    fileprivate var progressBar: HorizontalProgressbar?
    
    fileprivate var scrollViewConstraint: NSLayoutConstraint?
    
    var shouldRecieveTapGestures: Bool {
        return true
    }
    
    var keyboardHeight: CGFloat = 0.0
    
    func getViewModel() -> BaseViewModel {
        preconditionFailure("BaseViewController subclass must provide a subclass of BaseViewModel")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setObservers()
        
        getViewModel().viewDidLoad()
        configureProgressBar()
        self.alert = CustomAlert(on: self.view)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    fileprivate func configureProgressBar() {
        progressBar = HorizontalProgressbar(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height)! - 3, width: (self.navigationController?.navigationBar.frame.size.width)!, height: 3))
        self.navigationController?.navigationBar.addSubview(progressBar!)
        progressBar?.progressTintColor = .label
        progressBar?.trackTintColor = .darkGray
        progressBar?.noOfChunks = 2
        progressBar?.kChunkWdith = 300
    }
    
    func hideNavigationBar(_ shouldHide: Bool = true) {
        navigationController?.navigationBar.isHidden = shouldHide
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        expandScrollView()
    }
    
    func addScrollViewListener(constraint: NSLayoutConstraint) {
        self.scrollViewConstraint = constraint
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 6, options: [], animations: ({
                if keyboardRectangle.origin.y >= self.view.frame.height {
                    self.scrollViewConstraint?.constant = 0
                } else {
                    self.scrollViewConstraint?.constant = self.keyboardHeight
                }
                self.view.layoutIfNeeded()
            }), completion: nil)
        }
    }
    
    func expandScrollView() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 6, options: [], animations: ({
            self.scrollViewConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }), completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    private func setObservers() {
        observeLoadingState()
        observeErrorState()
        observeAlerts()
        setChildViewControllerObservers()
    }
    
    func setChildViewControllerObservers() {}
    
    private func observeAlerts() {
        getViewModel().alertMessage.bind { [weak self] value in
            self?.showAlert(message: value.message, type: value.type)
        }.disposed(by: disposeBag)
    }
    
    private func observeLoadingState() {
        getViewModel().isLoading.bind { [weak self] value in
            if value {
                self?.showLoading()
            } else {
                self?.hideLoading()
            }
        }.disposed(by: disposeBag)
    }
    
    private func observeErrorState() {
        getViewModel().error.asObserver().bind { [weak self] error in
            self?.showAlert(message: error.localizedDescription, type: .error)
        }.disposed(by: disposeBag)
    }
    
    private func showLoading() {
        configureProgressBar()
        progressBar?.startAnimating()
    }
    
    private func hideLoading() {
        progressBar?.stopAnimating()
    }
    
    func showAlert(message: String, type: AlertType, dismissCompletion: (() -> Void)? = nil) {
        self.alert?.showAlert(text: message, type: type, dismissCompletion: dismissCompletion)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getViewModel().viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        alert?.hideAlert()
        getViewModel().viewWillDisappear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getViewModel().viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        getViewModel().viewDidDisappear()
    }

}

//MARK: - UIGestureRecognizerDelegate

extension BaseViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return shouldRecieveTapGestures
    }
    
}
