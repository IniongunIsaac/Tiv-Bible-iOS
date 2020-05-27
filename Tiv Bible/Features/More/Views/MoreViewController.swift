//
//  MoreViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController {

    var moreViewModel: IMoreViewModel!
    
    override func getViewModel() -> BaseViewModel {
        return moreViewModel as! BaseViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
