//
//  VersesViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit
import RxSwift

class VersesViewController: UIViewController {

    @IBOutlet weak var versesCollectionView: UICollectionView!
    
    fileprivate let disposeBag = DisposeBag()
    var verses = [Verse]()
    var verseSelectedHandler: ((Verse) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    fileprivate func configureViews() {
        setupVersesCollectionView()
    }
    
    fileprivate func setupVersesCollectionView() {
        versesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        verses.asObservable.map({ $0.isEmpty }).distinctUntilChanged().bind(to: versesCollectionView.rx.isEmpty(message: "Verses for selected chapter will be shown here!")).disposed(by: disposeBag)
        
        verses.asObservable.bind(to: versesCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.verseCollectionViewCell.identifier, cellType: VerseCollectionViewCell.self)) { row, verse, cell in
            
            cell.configureView(verse: verse)
            
            cell.animateViewOnTapGesture { [weak self] in
                self?.handleVerseSelected(verse)
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleVerseSelected(_ verse: Verse) {
        verse.isSelected = true
        verses.filter { $0.id != verse.id }.forEach { $0.isSelected = false }
        versesCollectionView.reloadData()
        verseSelectedHandler?(verse)
    }

}


//MARK: - UICollectionViewDelegateFlowLayout
extension VersesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //CGSize(width: (width - (40 + (15 * 5))) / 5, height: 60)
        let cellsPerRow = AppConstants.numberItemsPerRow
        ///40 => paddingRight(20) + paddingLeft(20)
        ///15 => spacing between cells
        let cellWidth = width.int! - (40 + (15 * cellsPerRow))
        
        return CGSize(width: (cellWidth / cellsPerRow), height: (currentDevice.isPad ? 80 : 60))
    }
    
}
