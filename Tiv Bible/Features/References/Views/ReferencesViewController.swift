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
    
    var referencesViewModel: IReferenceViewModel!
    override func getViewModel() -> BaseViewModel { referencesViewModel as! BaseViewModel }
    override var views: [UIView] { [booksView, chaptersView, versesView] }
    override var horizontalProgressBarYPosition: CGFloat { referencesStackView.maxY - 5 }
    
    fileprivate var books: [Book] { referencesViewModel.books }
    fileprivate var chapters: [Chapter] { referencesViewModel.chapters }
    fileprivate var verses: [Verse] { referencesViewModel.verses }
    
    fileprivate var currentlyVisibleViewController: UIViewController?
    
    fileprivate var booksViewController: BooksViewController {
        R.storyboard.references.booksViewController()!.apply {
            $0.books = books
        }
    }
    
    fileprivate var chaptersViewController: ChaptersViewController {
        R.storyboard.references.chaptersViewController()!.apply {
            $0.chapters = chapters
        }
    }
    
    fileprivate var versesViewController: VersesViewController {
        R.storyboard.references.versesViewController()!.apply {
            $0.verses = verses
        }
    }
    
    override func configureViews() {
        super.configureViews()
        [booksView, chaptersView, versesView].addClearBackground()
        referencesViewModel.getBooks()
    }
    
    override func setupTapGestures() {
        booksView.animateViewOnTapGesture { [weak self] in
            self?.showReferenceSegment(.books)
        }
        
        chaptersView.animateViewOnTapGesture { [weak self] in
            self?.showReferenceSegment(.chapters)
        }
        
        versesView.animateViewOnTapGesture { [weak self] in
            self?.showReferenceSegment(.verses)
        }
    }
    
    fileprivate func showReferenceSegment(_ segment: ReferenceSegment) {
        if let vc = currentlyVisibleViewController {
            remove(asChildViewController: vc)
        }
        
        switch segment {
        case .books:
            currentlyVisibleViewController = booksViewController
            updateReferenceView(view: booksView)
            updateReferenceView(view: chaptersView, isActive: false)
            updateReferenceView(view: versesView, isActive: false)
            
        case .chapters:
            currentlyVisibleViewController = chaptersViewController
            updateReferenceView(view: booksView, isActive: false)
            updateReferenceView(view: chaptersView)
            updateReferenceView(view: versesView, isActive: false)
            
        case .verses:
            currentlyVisibleViewController = versesViewController
            updateReferenceView(view: booksView, isActive: false)
            updateReferenceView(view: chaptersView, isActive: false)
            updateReferenceView(view: versesView)
        }
        
        showChildViewController(currentlyVisibleViewController!)
    }
    
    fileprivate func updateReferenceView(view: ReferenceView, isActive: Bool = true) {
        view.activate(isActive)
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeShowReferenceSegment()
    }
    
    fileprivate func observeShowReferenceSegment() {
        referencesViewModel.showReferenceSegment.bind { [weak self] segment in
            self?.showReferenceSegment(segment)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func showChildViewController(_ viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.anchor(top: referencesStackView.bottomAnchor, paddingTop: 30, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, left: view.leftAnchor, paddingLeft: 20, right: view.rightAnchor, paddingRight: 20)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
        
    }
}
