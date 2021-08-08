//
//  ReferencesViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 07/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class ReferencesViewController: BaseBottomPopupViewController {
    
    @IBOutlet weak var referencesStackView: UIStackView!
    @IBOutlet weak var booksView: ReferenceView!
    @IBOutlet weak var chaptersView: ReferenceView!
    @IBOutlet weak var versesView: ReferenceView!
    
    var readViewModel: IReadViewModel!
    override func getViewModel() -> BaseViewModel { readViewModel as! BaseViewModel }
    override var views: [UIView] { [booksView, chaptersView, versesView] }
    override var horizontalProgressBarYPosition: CGFloat { referencesStackView.maxY - 5 }
    
    override func configureViews() {
        super.configureViews()
        [booksView, chaptersView, versesView].addClearBackground()
    }
    
    override func setupTapGestures() {
        booksView.animateViewOnTapGesture { [weak self] in
            self?.booksView.activate()
            self?.chaptersView.activate(false)
            self?.versesView.activate(false)
        }
        
        chaptersView.animateViewOnTapGesture { [weak self] in
            self?.booksView.activate(false)
            self?.chaptersView.activate()
            self?.versesView.activate(false)
        }
        
        versesView.animateViewOnTapGesture { [weak self] in
            self?.booksView.activate(false)
            self?.chaptersView.activate(false)
            self?.versesView.activate()
        }
    }
}
