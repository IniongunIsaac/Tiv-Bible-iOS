//
//  BookmarksViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class BookmarksViewController: BaseViewController {

    @IBOutlet weak var bookmarksTableView: UITableView!
    
    var moreViewModel: IMoreViewModel!
    override func getViewModel() -> BaseViewModel { moreViewModel as! BaseViewModel }
    
    fileprivate var selectedBookmark: Bookmark!
    
    override func configureViews() {
        super.configureViews()
        setupBookmarksTableView()
        moreViewModel.getBookmarks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar(false)
        title = "Bookmarks"
    }
    
    fileprivate func setupBookmarksTableView() {
        
        moreViewModel.bookmarks.map({ $0.isEmpty }).distinctUntilChanged().bind(to: bookmarksTableView.rx.isEmpty(message: "Bookmarks will be shown here!")).disposed(by: disposeBag)
        
        moreViewModel.bookmarks.bind(to: bookmarksTableView.rx.items(cellIdentifier: R.reuseIdentifier.bookmarkTableViewCell.identifier, cellType: BookmarkTableViewCell.self)) { index, bookmark, cell in
            
            cell.configureView(bookmark: bookmark)
            
            cell.animateViewOnTapGesture { [weak self] in
                self?.selectedBookmark = bookmark
                self?.handleBookmarkSelected()
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleBookmarkSelected() {
        showTapActionsViewController(actionChosenHandler: handleTapActionSelected(_:)) { [weak self] in
            guard let self = self else { return }
            self.moreViewModel.deleteBookmark(self.selectedBookmark)
        }
    }
    
    fileprivate func handleTapActionSelected(_ action: TapAction) {
        switch action {
        case .readFullChapter:
            break
        case .share:
            break
        case .copy:
            break
        case .delete, .dismiss:
            break
        }
    }

}
