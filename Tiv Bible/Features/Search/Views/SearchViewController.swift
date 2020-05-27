//
//  SearchViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    var searchViewModel: ISearchViewModel!
    
    override func getViewModel() -> BaseViewModel {
        return searchViewModel as! BaseViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
