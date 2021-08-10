//
//  MoreViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController {

    @IBOutlet weak var moreItemsTableView: UITableView!
    
    var moreViewModel: IMoreViewModel!
    override func getViewModel() -> BaseViewModel { moreViewModel as! BaseViewModel }
    
    override func configureViews() {
        super.configureViews()
        hideNavBar()
        setupMoreItemsTableView()
    }
    
    fileprivate func setupMoreItemsTableView() {
        MoreItem.allCases.asObservable.bind(to: moreItemsTableView.rx.items(cellIdentifier: R.reuseIdentifier.moreItemTableViewCell.identifier, cellType: MoreItemTableViewCell.self)) { index, item, cell in
            
            cell.configureView(item: item)
            
            cell.animateViewOnTapGesture { [weak self] in
                self?.handleItemSelected(item)
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleItemSelected(_ item: MoreItem) {
        switch item {
        case .bookmarks:
            pushViewController(R.storyboard.more.bookmarksViewController()!)
        case .highlights:
            pushViewController(R.storyboard.more.highlightsViewController()!)
        case .notes:
            pushViewController(R.storyboard.more.notesViewController()!)
        case .history:
            pushViewController(R.storyboard.more.historyViewController()!)
        case .apostlesCreed:
            pushViewController(R.storyboard.others.apostlesCreedViewController()!)
        case .commandments:
            pushViewController(R.storyboard.others.commandmentsViewController()!)
        case .lordsPrayer:
            pushViewController(R.storyboard.others.lordsPrayerViewController()!)
        case .share:
            break
        case .rating:
            break
        case .settings:
            pushViewController(R.storyboard.others.settingsViewController()!)
        }
    }

}
