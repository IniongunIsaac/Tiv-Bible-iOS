//
//  ReadViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ReadViewController: BaseViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bookChapterStackView: UIStackView!
    @IBOutlet weak var bookChapterLabel: UILabel!
    @IBOutlet weak var fontStyleButton: UIButton!
    @IBOutlet weak var versesTableView: UITableView!
    @IBOutlet weak var tapActionsView: UIView!
    @IBOutlet weak var closeTapActionsImageView: UIImageView!
    @IBOutlet weak var selectedVersesLabel: UILabel!
    @IBOutlet weak var removeHighlightColorImageView: UIImageView!
    @IBOutlet weak var fontSettingsView: UIView!
    @IBOutlet weak var closeFontSettingsImageView: UIImageView!
    @IBOutlet weak var increaseFontSizeView: ViewWithBorderAttributes!
    @IBOutlet weak var decreaseFontSizeView: ViewWithBorderAttributes!
    @IBOutlet weak var currentFontSizeLabel: UILabel!
    @IBOutlet weak var lineSpacingTwoView: ViewWithBorderAttributes!
    @IBOutlet weak var lineSpacingThreeView: ViewWithBorderAttributes!
    @IBOutlet weak var lineSpacingFourView: ViewWithBorderAttributes!
    @IBOutlet weak var fontStyleCollectionView: UICollectionView!
    @IBOutlet weak var themesCollectionView: UICollectionView!
    @IBOutlet weak var goToSettingsView: ViewWithBorderAttributes!
    @IBOutlet weak var shareView: ViewWithBorderAttributes!
    @IBOutlet weak var bookmarkView: ViewWithBorderAttributes!
    @IBOutlet weak var copyView: ViewWithBorderAttributes!
    @IBOutlet weak var takeNotesView: ViewWithBorderAttributes!
    @IBOutlet weak var highlightColorsStackView: UIStackView!
    
    var readViewModel: IReadViewModel!
    override func getViewModel() -> BaseViewModel { readViewModel as! BaseViewModel }
    
    fileprivate var isShowingTapActions = false
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        [tapActionsView, fontSettingsView].addRoundCorners([.topLeft, .topRight], radius: 10)
    }
    
    override func configureViews() {
        super.configureViews()
        hideNavigationBar()
        setTapGestures()
        [tapActionsView, fontSettingsView].hideViews()
    }
    
    fileprivate func setTapGestures() {
        bookChapterStackView.animateViewOnTapGesture { [weak self] in
            
        }
        
        shareView.animateViewOnTapGesture { [weak self] in
            guard let self = self else { return }
            self.share(content: self.readViewModel.shareableSelectedVersesText)
        }
        
        bookmarkView.animateViewOnTapGesture { [weak self] in
            
        }
        
        copyView.animateViewOnTapGesture { [weak self] in
            
        }
        
        takeNotesView.animateViewOnTapGesture { [weak self] in
            
        }
    }
    
    @IBAction func fontStyleButtonTapped(_ sender: UIButton) {
        fontStyleButton.animateView { [weak self] in
            
        }
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeCurrentVerses()
        observeBookNameAndChapterNumber()
        observeVerseSelected()
        observeSelectedVersesText()
        observeHighlightColorsFontStylesAndThemes()
    }
    
    fileprivate func observeCurrentVerses() {
        readViewModel.currentVerses.bind(to: versesTableView.rx.items(cellIdentifier: R.reuseIdentifier.verseTableViewCell.identifier, cellType: VerseTableViewCell.self)) { row, verse, cell in
            
            cell.configureView(verse: verse)
            
            cell.addTapGesture { [weak self] in
                self?.handleVerseTapped(verse)
            }
            
        }.disposed(by: disposeBag)
        
    }
    
    fileprivate func handleVerseTapped(_ verse: Verse) {
        readViewModel.toggleSelectedVerse(verse: verse)
        if readViewModel.selectedVerses.isNotEmpty {
            showTapActions()
        } else {
            self.isShowingTapActions = false
            self.tapActionsView.fadeOut()
        }
    }
    
    fileprivate func observeVerseSelected() {
        readViewModel.verseSelected.bind { [weak self] selected in
            self?.versesTableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    fileprivate func observeBookNameAndChapterNumber() {
        readViewModel.bookNameAndChapterNumber.bind(to: bookChapterLabel.rx.text).disposed(by: disposeBag)
    }
    
    fileprivate func observeSelectedVersesText() {
        readViewModel.selectedVersesText.bind(to: selectedVersesLabel.rx.text).disposed(by: disposeBag)
    }
    
    fileprivate func observeHighlightColorsFontStylesAndThemes() {
        readViewModel.highlightColorsFontStylesAndThemes.bind { [weak self] data in
            
            self?.configureHighlightColors(data.highlightColors)
            self?.configureFontStyles(data.fontStyles)
            self?.configureThemes(data.themes)
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func configureHighlightColors(_ highlightColors: [HighlightColor]) {
        highlightColors.forEach { [weak self] highlightColor in
            
            let view = UIView().apply {
                $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
                $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
                $0.backgroundColor = UIColor(highlightColor.hexCode)
                $0.addCornerRadius(radius: 20)
                $0.animateViewOnTapGesture { [weak self] in
                    
                }
            }
            
            self?.highlightColorsStackView.addArrangedSubview(view)
        }
    }
    
    fileprivate func configureFontStyles(_ fontStyles: [FontStyle]) {
        fontStyles.forEach { fontStyle in
            
        }
    }
    
    fileprivate func configureThemes(_ themes: [Theme]) {
        themes.forEach { theme in
            
        }
    }
    
    fileprivate func showTapActions() {
        if !isShowingTapActions {
            isShowingTapActions = true
            tapActionsView.fadeIn()
        }
    }
    
}
