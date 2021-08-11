//
//  HighlightsViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class HighlightsViewController: BaseViewController {
    
    @IBOutlet weak var highlightsTableView: UITableView!
    
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
    
    fileprivate var selectedHighlight: Highlight!

    override func configureViews() {
        super.configureViews()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: clearAllButton)
        setupHighlightsTableView()
        moreViewModel.getHighlights()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar(false)
        title = "Highlights"
    }
    
    fileprivate func setupHighlightsTableView() {
        moreViewModel.highlights.map({ $0.isEmpty }).distinctUntilChanged().bind(to: highlightsTableView.rx.isEmpty(message: "Highlights will be shown here!")).disposed(by: disposeBag)
        
        moreViewModel.highlights.bind(to: highlightsTableView.rx.items(cellIdentifier: R.reuseIdentifier.highlightTableViewCell.identifier, cellType: HighlightTableViewCell.self)) { index, highlight, cell in
            
            cell.configureView(highlight: highlight)
            
            cell.animateViewOnTapGesture { [weak self] in
                self?.selectedHighlight = highlight
                self?.handleHighlightSelected()
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleHighlightSelected() {
        showTapActionsViewController(actionChosenHandler: handleTapActionSelected(_:)) { [weak self] in
            guard let self = self else { return }
            self.moreViewModel.deleteHighlight(self.selectedHighlight)
        }
    }
    
    fileprivate func handleTapActionSelected(_ action: TapAction) {
        switch action {
        case .readFullChapter:
            selectedHighlight.do {
                moreViewModel.readFullChapter(bookId: $0.book!.id, chapterId: $0.chapter!.id, verseId: $0.verse!.id, verseNumber: $0.verse!.number)
            }
        case .share:
            share(content: selectedHighlight.shareableText)
        case .copy:
            selectedHighlight.shareableText.copyToClipboard()
            showAlert(message: "Highlight copied!", type: .success)
        case .delete, .dismiss:
            break
        }
    }
    
    @objc fileprivate func clearAllButtonTapped() {
        showConfirmationViewController(prompt: "Are you sure you want to delete all your highlights?") { [weak self] in
            self?.moreViewModel.deleteAllHighlights()
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
