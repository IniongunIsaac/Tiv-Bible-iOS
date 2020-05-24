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
        return vm
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func stopTapped(_ sender: Any) {
        vm.stop()
    }
    
    @IBAction func startTapped(_ sender: Any) {
        vm.start()
    }
    
}

