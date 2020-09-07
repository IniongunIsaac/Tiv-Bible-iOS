//
//  NewViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 30/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class NewViewModel: BaseViewModel {
    
}

class NewViewController: BaseViewController {

    @IBOutlet weak var bookChapterButton: UIButton!
    @IBOutlet weak var fontSettingsButton: UIButton!
    
    override func getViewModel() -> BaseViewModel {
        return NewViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        //navigationController?.navigationBar.isHidden = true
    }

    @IBAction func bookChapterButtonTapped(_ sender: Any) {
        debugPrint("bookChapterButtonTapped")
    }
    
    @IBAction func fontSettingsButtonTapped(_ sender: Any) {
        debugPrint("fontSettingsButtonTapped")
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        debugPrint("buttonTapped")
    }
}
