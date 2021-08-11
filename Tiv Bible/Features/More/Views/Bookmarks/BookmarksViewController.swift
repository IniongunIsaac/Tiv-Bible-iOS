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
        setupBookmarksTableView()
        moreViewModel.getBookmarks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar(false)
        title = "Bookmarks"
    }
    
    @objc fileprivate func clearAllButtonTapped() {
        clearAllButton.animateView { [weak self] in
            self?.showConfirmationViewController(prompt: "Are you sure you want to delete all your bookmarks?") { [weak self] in
                self?.moreViewModel.deleteAllBookmarks()
            }
        }
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
            selectedBookmark.do {
                moreViewModel.readFullChapter(bookId: $0.book!.id, chapterId: $0.chapter!.id, verseId: $0.verse!.id, verseNumber: $0.verse!.number)
            }
        case .share:
            share(content: selectedBookmark.shareableText)
        case .copy:
            selectedBookmark.shareableText.copyToClipboard()
            showAlert(message: "Bookmark copied!", type: .success)
        case .delete, .dismiss:
            break
        }
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeShowReaderView()
    }
    
    fileprivate func observeShowReaderView() {
        moreViewModel.showReaderView.bind { [weak self] show in
            if show {
                self?.navigateToTab(.read)
            }
        }.disposed(by: disposeBag)
    }

}
