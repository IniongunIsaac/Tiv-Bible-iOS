//
//  ReferencesViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 07/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import BottomPopup

class ReferencesViewController: BottomPopupViewController {
    
    @IBOutlet weak var referencesStackView: UIStackView!
    @IBOutlet weak var booksView: ReferenceView!
    @IBOutlet weak var chaptersView: ReferenceView!
    @IBOutlet weak var versesView: ReferenceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [booksView, chaptersView, versesView].addClearBackground()
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
    
    override var popupTopCornerRadius: CGFloat { 20 }
    
    override var popupHeight: CGFloat { height - 100 }
}
