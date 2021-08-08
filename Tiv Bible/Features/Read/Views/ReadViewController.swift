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
    @IBOutlet weak var bookChapterView: UIView!
    @IBOutlet weak var bookChapterLabel: UILabel!
    @IBOutlet weak var fontStyleButton: UIButton!
    @IBOutlet weak var versesTableView: UITableView!
    @IBOutlet weak var tapActionsView: UIView!
    @IBOutlet weak var closeTapActionsImageView: UIImageView!
    @IBOutlet weak var selectedVersesLabel: UILabel!
    @IBOutlet weak var removeHighlightColorImageView: UIImageView!
    @IBOutlet weak var fontSettingsView: UIView!
    @IBOutlet weak var closeFontSettingsImageView: UIImageView!
    @IBOutlet weak var increaseFontSizeView: UIView!
    @IBOutlet weak var decreaseFontSizeView: UIView!
    @IBOutlet weak var currentFontSizeLabel: UILabel!
    @IBOutlet weak var smallLineSpacingView: UIView!
    @IBOutlet weak var normalLineSpacingView: UIView!
    @IBOutlet weak var largeLineSpacingView: UIView!
    @IBOutlet weak var fontStyleCollectionView: UICollectionView!
    @IBOutlet weak var goToSettingsView: UIView!
    @IBOutlet weak var shareView: ViewWithBorderAttributes!
    @IBOutlet weak var bookmarkView: ViewWithBorderAttributes!
    @IBOutlet weak var copyView: ViewWithBorderAttributes!
    @IBOutlet weak var takeNotesView: ViewWithBorderAttributes!
    @IBOutlet weak var highlightColorsStackView: UIStackView!
    @IBOutlet weak var systemThemeView: UIView!
    @IBOutlet weak var darkThemeView: UIView!
    @IBOutlet weak var lightThemeView: UIView!
    @IBOutlet weak var themesStackView: UIStackView!
    
    var readViewModel: IReadViewModel!
    override func getViewModel() -> BaseViewModel { readViewModel as! BaseViewModel }
    override var views: [UIView] { [bookChapterView, tapActionsView, fontSettingsView, shareView, bookmarkView, copyView, takeNotesView, closeTapActionsImageView, closeFontSettingsImageView, systemThemeView, darkThemeView, lightThemeView, goToSettingsView, increaseFontSizeView, decreaseFontSizeView, smallLineSpacingView, normalLineSpacingView, largeLineSpacingView, removeHighlightColorImageView] }
    
    fileprivate var isShowingTapActions = false
    fileprivate var isShowingFontSettings = false
    fileprivate var shareableText: String { readViewModel.shareableSelectedVersesText }
    fileprivate var selectedVersesText = ""
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        [tapActionsView, fontSettingsView].addRoundCorners([.topLeft, .topRight], radius: 20)
    }
    
    override func configureViews() {
        super.configureViews()
        hideNavigationBar()
        [tapActionsView, fontSettingsView].hideViews()
        switchAppTheme(type: readViewModel.currentTheme)
    }
    
    override func setupTapGestures() {
        bookChapterView.animateViewOnTapGesture { [weak self] in
            self?.presentViewController(R.storyboard.read.referencesViewController()!)
        }
        
        shareView.animateViewOnTapGesture { [weak self] in
            guard let self = self else { return }
            self.share(content: self.shareableText)
        }
        
        bookmarkView.animateViewOnTapGesture { [weak self] in
            self?.readViewModel.saveBookmarks()
        }
        
        copyView.animateViewOnTapGesture { [weak self] in
            self?.shareableText.copyToClipboard()
            self?.showAlert(message: "Selected verses copied to clipboard successfully!", type: .success)
        }
        
        takeNotesView.animateViewOnTapGesture(completion: handleTakeNotesTapped)
        
        closeTapActionsImageView.animateViewOnTapGesture { [weak self] in
            self?.isShowingTapActions = false
            self?.tapActionsView.fadeOut()
        }
        
        closeFontSettingsImageView.animateViewOnTapGesture { [weak self] in
            self?.isShowingFontSettings = false
            self?.fontSettingsView.fadeOut()
        }
        
        systemThemeView.animateViewOnTapGesture { [weak self] in
            self?.switchAppTheme(type: .system)
        }
        
        darkThemeView.animateViewOnTapGesture { [weak self] in
            self?.switchAppTheme(type: .dark)
        }
        
        lightThemeView.animateViewOnTapGesture { [weak self] in
            self?.switchAppTheme(type: .light)
        }
        
        goToSettingsView.animateViewOnTapGesture { [weak self] in
            self?.hideTapActionsAndFontSettingsViews()
            self?.navigateToTab(.more)
        }
        
        increaseFontSizeView.animateViewOnTapGesture { [weak self] in
            self?.readViewModel.increaseFontSize()
        }
        
        decreaseFontSizeView.animateViewOnTapGesture { [weak self] in
            self?.readViewModel.decreaseFontSize()
        }
        
        smallLineSpacingView.animateViewOnTapGesture { [weak self] in
            self?.readViewModel.updateLineSpacing(type: .small)
        }
        
        normalLineSpacingView.animateViewOnTapGesture { [weak self] in
            self?.readViewModel.updateLineSpacing(type: .normal)
        }
        
        largeLineSpacingView.animateViewOnTapGesture { [weak self] in
            self?.readViewModel.updateLineSpacing(type: .large)
        }
        
        removeHighlightColorImageView.animateViewOnTapGesture { [weak self] in
            self?.readViewModel.removeHighlightsFromSelectedVerses()
        }
    }
    
    @IBAction func fontStyleButtonTapped(_ sender: UIButton) {
        fontStyleButton.animateView { [weak self] in
            self?.showFontSettings()
        }
    }
    
    fileprivate func switchAppTheme(type theme: Theme) {
        if #available(iOS 13.0, *) {
            view.window?.do {
                switch theme {
                case .system:
                    $0.overrideUserInterfaceStyle = .unspecified
                case .dark:
                    $0.overrideUserInterfaceStyle = .dark
                case .light:
                    $0.overrideUserInterfaceStyle = .light
                }
            }
            readViewModel.currentTheme = theme
            updateThemeViews(theme: theme)
        } else {
            themesStackView.hideView()
        }
    }
    
    fileprivate func updateThemeViews(theme: Theme) {
        updateThemeView(systemThemeView, isActive: theme == .system)
        updateThemeView(darkThemeView, isActive: theme == .dark)
        updateThemeView(lightThemeView, isActive: theme == .light)
    }
    
    fileprivate func updateThemeView(_ themeView: UIView, isActive: Bool) {
        ((themeView.subviews.first as? UIStackView)?.subviews.filter { $0 is UIImageView }.first as? UIImageView)?.showView(isActive)
    }
    
    fileprivate func handleTakeNotesTapped() {
        showDialog(for: R.storyboard.read.takeNotesDialogViewController()!.apply {
            $0.selectedVersesText = selectedVersesText
            $0.saveNotesHandler = { [weak self] notes in
                self?.readViewModel.saveNotes(notes)
            }
        })
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeCurrentVerses()
        observeBookNameAndChapterNumber()
        observeReloadVerses()
        observeSelectedVersesText()
        observeHighlightColorsFontStylesAndThemes()
        observeCurrentSettingsChanges()
    }
    
    fileprivate func observeCurrentVerses() {
        readViewModel.currentVerses.bind(to: versesTableView.rx.items(cellIdentifier: R.reuseIdentifier.verseTableViewCell.identifier, cellType: VerseTableViewCell.self)) { [weak self] row, verse, cell in
            guard let self = self else { return }
            
            cell.configureView(verse: verse, settings: self.readViewModel.currentSettings!)
            
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
    
    fileprivate func observeReloadVerses() {
        readViewModel.reloadVerses.bind { [weak self] reload in
            if reload {
                self?.versesTableView.reloadData()
            }
        }.disposed(by: disposeBag)
    }
    
    fileprivate func observeBookNameAndChapterNumber() {
        readViewModel.bookNameAndChapterNumber.bind(to: bookChapterLabel.rx.text).disposed(by: disposeBag)
    }
    
    fileprivate func observeSelectedVersesText() {
        readViewModel.selectedVersesText.bind { [weak self] text in
            self?.selectedVersesLabel .text = text
            self?.selectedVersesText = text
        }.disposed(by: disposeBag)
    }
    
    fileprivate func observeHighlightColorsFontStylesAndThemes() {
        readViewModel.highlightColorsAndFontStyles.bind { [weak self] data in
            
            self?.configureHighlightColors(data.highlightColors)
            self?.configureFontStyles(data.fontStyles)
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func observeCurrentSettingsChanges() {
        readViewModel.updateUIWithCurrentSettings.bind { [weak self] update in
            if update {
                guard let self = self else { return }
                self.versesTableView.reloadData()
                self.currentFontSizeLabel.text = "\(self.readViewModel.currentSettings!.fontSize)px"
                self.fontStyleCollectionView.reloadData()
            }
        }.disposed(by: disposeBag)
    }
    
    fileprivate func configureHighlightColors(_ highlightColors: [HighlightColor]) {
        highlightColors.forEach { [weak self] color in
            
            let view = UIView().apply {
                $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
                $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
                $0.backgroundColor = UIColor(color.hexCode)
                $0.addCornerRadius(radius: 20)
                $0.animateViewOnTapGesture { [weak self] in
                    self?.readViewModel.setHighlightColorForSelectedVerses(color)
                }
            }
            
            self?.highlightColorsStackView.addArrangedSubview(view)
        }
    }
    
    fileprivate func configureFontStyles(_ fontStyles: [FontStyle]) {
        fontStyleCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        Observable.just(fontStyles).bind(to: fontStyleCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.fontStyleCollectionViewCell.identifier, cellType: FontStyleCollectionViewCell.self)) { [weak self] row, font, cell in
            guard let self = self else { return }
            
            cell.configureView(font: font, settings: self.readViewModel.currentSettings!)
            
            cell.addTapGesture { [weak self] in
                self?.readViewModel.updateSelectedFontStyle(font)
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func showTapActions() {
        if isShowingFontSettings {
            isShowingFontSettings = false
            fontSettingsView.fadeOut()
        }
        
        if !isShowingTapActions {
            isShowingTapActions = true
            tapActionsView.fadeIn()
        }
    }
    
    fileprivate func showFontSettings() {
        if isShowingTapActions {
            isShowingTapActions = false
            tapActionsView.fadeOut()
        }
        
        if !isShowingFontSettings {
            isShowingFontSettings = true
            fontSettingsView.fadeIn()
        }
    }
    
    fileprivate func hideTapActionsAndFontSettingsViews() {
        if isShowingFontSettings {
            isShowingFontSettings = false
            fontSettingsView.fadeOut()
        }
        
        if isShowingTapActions {
            isShowingTapActions = false
            tapActionsView.fadeOut()
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ReadViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: collectionView.height)
    }
    
}
