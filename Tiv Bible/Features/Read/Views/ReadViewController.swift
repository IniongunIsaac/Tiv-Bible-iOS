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
    
    override func getViewModel() -> BaseViewModel {
        return readViewModel as! BaseViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setTapGestures()
        //tapActionsView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readViewModel.getBookFromSavedPreferencesOrInitializeWithGenese()
        //readViewModel.getUserSettings()
        readViewModel.getHighlightColorsFontStylesAndThemes()
    }
    
    fileprivate func setTapGestures() {
        bookChapterStackView.addTapGesture { [weak self] in
            self?.bookChapterStackView.animateOnClick(completion: {
                
            })
        }
    }
    
    @IBAction func fontStyleButtonTapped(_ sender: UIButton) {
        self.showTapActions()
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
        readViewModel.currentVerses.bind(to: versesTableView.rx.items(cellIdentifier: AppConstants.VERSE_CELL_ID, cellType: VerseTableViewCell.self)) { row, verse, cell in
            
            cell.configureView(verse: verse)
            
            cell.addTapGesture { [weak self] in
                guard let self = self else { return }
                self.readViewModel.toggleSelectedVerse(verse: verse)
//                if !self.readViewModel.selectedVerses.isEmpty {
//                    self.showTapActions()
//                } else {
//                    self.tapActionsView.fadeOut()
//                }
            }
            
        }.disposed(by: disposeBag)
        
        versesTableView.rx.modelSelected(Verse.self).subscribe(onNext: { verse in
            self.readViewModel.toggleSelectedVerse(verse: verse)
            
//                            if !self.readViewModel.selectedVerses.isEmpty {
//                                self.showTapActions()
//                            } else {
//                                self.tapActionsView.fadeOut()
//                            }
            
            }).disposed(by: disposeBag)
        
//        versesTableView.rx.itemSelected.subscribe(onNext: { indexPath in
//            debugPrint("cell tapped.")
//            }).disposed(by: disposeBag)
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
        //highlightColorsStackView.arrangedSubviews.forEach { highlightColorsStackView.removeArrangedSubview($0) }
        
        highlightColors.forEach { [weak self] highlightColor in
            
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
            view.widthAnchor.constraint(equalToConstant: 40).isActive = true
            view.backgroundColor = UIColor(highlightColor.hexCode)
            view.addCornerRadius(radius: 20)
//            view.addTapGesture {
//                debugPrint("highlight color: \(highlightColor.hexCode)")
//            }
            
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
        tapActionsView.isHidden = false
    }
    
}
