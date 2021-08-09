//
//  SearchChaptersViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 09/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import BottomPopup
import RxSwift

class SearchChaptersViewController: BottomPopupViewController {
    
    @IBOutlet weak var chaptersCollectionView: UICollectionView!
    
    fileprivate let disposeBag = DisposeBag()
    var chapters = [Chapter]()
    var chapterSelectedHandler: ((Chapter) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    fileprivate func configureViews() {
        setupChaptersCollectionView()
    }
    
    fileprivate func setupChaptersCollectionView() {
        chaptersCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        chapters.asObservable.map({ $0.isEmpty }).distinctUntilChanged().bind(to: chaptersCollectionView.rx.isEmpty(message: "Chapters for selected book will be shown here!")).disposed(by: disposeBag)
        
        chapters.asObservable.bind(to: chaptersCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.searchChapterCollectionViewCell.identifier, cellType: ChapterCollectionViewCell.self)) { row, chapter, cell in
            
            cell.configureView(chapter: chapter)
            
            cell.animateViewOnTapGesture { [weak self] in
                self?.handleChapterSelected(chapter)
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleChapterSelected(_ chapter: Chapter) {
        chapter.isSelected = true
        chapters.filter { $0.id != chapter.id }.forEach { $0.isSelected = false }
        chaptersCollectionView.reloadData()
        dismissViewController { [weak self] in
            self?.chapterSelectedHandler?(chapter)
        }
    }
    
    override var popupHeight: CGFloat { height - 200 }
    
    override var popupTopCornerRadius: CGFloat { 20 }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchChaptersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = AppConstants.numberItemsPerRow
        ///40 => paddingRight(20) + paddingLeft(20)
        ///15 => spacing between cells
        let cellWidth = width.int! - (40 + (15 * cellsPerRow))
        
        return CGSize(width: (cellWidth / cellsPerRow), height: 60)
    }
    
}

