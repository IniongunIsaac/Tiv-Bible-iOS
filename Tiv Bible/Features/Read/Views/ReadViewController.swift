//
//  ReadViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class ReadViewController: BaseViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bookChapterStackView: UIStackView!
    @IBOutlet weak var bookChapterLabel: UILabel!
    @IBOutlet weak var fontStyleButton: UIButton!
    @IBOutlet weak var versesTableView: UITableView!
    @IBOutlet weak var tapActionsView: UIView!
    @IBOutlet weak var closeTapActionsImageView: UIImageView!
    @IBOutlet weak var selectedVersesLabel: UILabel!
    @IBOutlet weak var tapActionsCollectionView: UICollectionView!
    @IBOutlet weak var removeHighlightColorImageView: UIImageView!
    @IBOutlet weak var highlightColorsCollectionView: UICollectionView!
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
    
    var readViewModel: IReadViewModel!
    
    override func getViewModel() -> BaseViewModel {
        return readViewModel as! BaseViewModel
    }
    
    override func addProgressBarConstraints() {
        mProgressBar.anchor(top: topView.bottomAnchor, paddingTop: 2, left: view.leftAnchor, right: view.rightAnchor, width: view.bounds.width, height: 3)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setTapGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readViewModel.getBookFromSavedPreferencesOrInitializeWithGenese()
    }
    
    fileprivate func setTapGestures() {
        bookChapterStackView.addTapGesture { [weak self] in
            self?.bookChapterStackView.animateOnClick(completion: {
                
            })
        }
    }
    
    @IBAction func fontStyleButtonTapped(_ sender: UIButton) {
        
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeCurrentVerses()
        observeBookNameAndChapterNumber()
        observeVerseSelected()
    }
    
    fileprivate func observeCurrentVerses() {
        readViewModel.currentVerses.bind(to: versesTableView.rx.items(cellIdentifier: AppConstants.VERSE_CELL_ID, cellType: VerseTableViewCell.self)) { row, verse, cell in
            
            cell.configureView(verse: verse)
            
            cell.addTapGesture { [weak self] in
                self?.readViewModel.toggleSelectedVerse(verse: verse)
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func observeVerseSelected() {
        readViewModel.verseSelected.bind { [weak self] selected in
            self?.versesTableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    fileprivate func observeBookNameAndChapterNumber() {
        readViewModel.bookNameAndChapterNumber.bind(to: bookChapterLabel.rx.text).disposed(by: disposeBag)
    }
    
}
