//
//  ViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 14/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
    var splashViewModel: ISplashViewModel!
    
    override func getViewModel() -> BaseViewModel {
        splashViewModel as! BaseViewModel
    }

    @IBOutlet weak var setupInProgressLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        splashViewModel.setupDB()
    }
    
    override func setChildViewControllerObservers() {
        observeShowHome()
        observeShowSetupInProgress()
    }
    
    fileprivate func observeShowHome() {
        splashViewModel.showHome.bind { [weak self] show in
            guard let self = self else { return }
            if show {
                self.showHome()
            }
        }.disposed(by: disposeBag)
    }
    
    fileprivate func observeShowSetupInProgress() {
        splashViewModel.showSetupInProgress.bind { [weak self] show in
            self?.setupInProgressLabel.showView(show)
            self?.versionLabel.showView(!show)
        }.disposed(by: disposeBag)
    }
    
}

