//
//  HistoryViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    var moreViewModel: IMoreViewModel!
    override func getViewModel() -> BaseViewModel { moreViewModel as! BaseViewModel }
    
    fileprivate var clearAllButton: UIButton {
        UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 30)).apply { btn in
            btn.title = "Clear All"
            btn.textColor = .appRed
            btn.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
            btn.font = .andesRoundedRegular(size: 14)
        }
    }
    
    override func configureViews() {
        super.configureViews()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: clearAllButton)
    }
    
    @objc fileprivate func clearAllButtonTapped() {
        clearAllButton.animateView { [weak self] in
            self?.showConfirmationViewController(prompt: "Are you sure you want to delete all your reading history?") { [weak self] in
                self?.moreViewModel.deleteAllHistory()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar(false)
        title = "Reading History"
    }
    
}
