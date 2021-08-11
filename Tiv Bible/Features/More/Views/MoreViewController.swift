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
        setupMoreItemsTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
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
            let creed = AppConstants.CREED
            let other = Other(title: creed.title, subTitle: creed.subTitle, text: creed.content)
            
            presentViewController(R.storyboard.others.othersViewController()!.apply {
                $0.other = other
            })
            
        case .commandments:
            let creed = AppConstants.COMMANDMENTS
            let other = Other(title: creed.title, subTitle: creed.subTitle, text: creed.content)
            
            presentViewController(R.storyboard.others.othersViewController()!.apply {
                $0.other = other
            })
            
        case .lordsPrayer:
            let creed = AppConstants.LORDS_PRAYER
            let other = Other(title: creed.title, subTitle: creed.subTitle, text: creed.content)
            
            presentViewController(R.storyboard.others.othersViewController()!.apply {
                $0.other = other
            })
            
        case .share:
            break
        case .rating:
            break
        case .settings:
            pushViewController(R.storyboard.others.settingsViewController()!)
        }
    }

}
