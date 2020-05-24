//
//  ViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 14/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
    let vm = SplashViewModel()
    
    override func getViewModel() -> BaseViewModel {
        vm
    }

    @IBOutlet weak var setupInProgressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }
    
    override func addProgressBarConstraints() {
        mProgressBar.anchor(top: setupInProgressLabel.bottomAnchor, paddingTop: 8, left: view.leftAnchor, right: view.rightAnchor, width: view.bounds.width - 10, height: 3)
    }
    
}

