//
//  ChaptersViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit
import RxSwift

class ChaptersViewController: UIViewController {

    @IBOutlet weak var chaptersCollectionView: UICollectionView!
    
    fileprivate let disposeBag = DisposeBag()
    var chapters = [Chapter]()
    
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
        
        chapters.asObservable.bind(to: chaptersCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.chapterCollectionViewCell.identifier, cellType: ChapterCollectionViewCell.self)) { row, chapter, cell in
            
            cell.configureView(chapter: chapter)
            
            cell.animateViewOnTapGesture { [weak self] in
                
            }
            
        }.disposed(by: disposeBag)
    }

}

//MARK: - UICollectionViewDelegateFlowLayout
extension ChaptersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: collectionView.height)
    }
    
}
