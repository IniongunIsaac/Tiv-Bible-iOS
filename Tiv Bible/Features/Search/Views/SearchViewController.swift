//
//  SearchViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var filtersContainerStackView: UIStackView!
    @IBOutlet weak var filtersContentStackView: UIStackView!
    @IBOutlet weak var bookDropdownView: DropdownView!
    @IBOutlet weak var chapterDropdownView: DropdownView!
    
    var searchViewModel: ISearchViewModel!
    override func getViewModel() -> BaseViewModel { searchViewModel as! BaseViewModel }
    override var views: [UIView] { [searchBar, searchResultsTableView, bookDropdownView, chapterDropdownView] }
    
    fileprivate var books: [Book] { searchViewModel.books }
    fileprivate var chapters: [Chapter] { searchViewModel.chapters }

    override func configureViews() {
        super.configureViews()
        [bookDropdownView, chapterDropdownView].addClearBackground()
        filtersContentStackView.removeAllArrangedSubviews()
        filtersContainerStackView.hideView()
        configureSearchBar()
        setupSearchResultsTableView()
    }
    
    override func setupTapGestures() {
        super.setupTapGestures()
        
        bookDropdownView.animateViewOnTapGesture { [weak self] in
            self?.handleBooksDropdownTapped()
        }
        
        chapterDropdownView.animateViewOnTapGesture { [weak self] in
            self?.handleChaptersDropdownTapped()
        }
    }
    
    fileprivate func handleBooksDropdownTapped() {
        if books.isEmpty {
            searchViewModel.getBooks(showBookReferences: true)
        } else {
            showSearchBooksViewController()
        }
    }
    
    fileprivate func showSearchBooksViewController() {
        presentViewController(R.storyboard.search.searchBooksViewController()!.apply {
            $0.books = books
            $0.bookSelectedHandler = { [weak self] book in
                self?.addBookFilter(book)
            }
        })
    }
    
    fileprivate func handleChaptersDropdownTapped() {
        guard let book = searchViewModel.selectedBook else {
            showAlert(message: "Please choose a book!", type: .error)
            return
        }
        if chapters.isEmpty {
            searchViewModel.getBookChapters(book, showChapterReferences: true)
        } else {
            showSearchChaptersViewController()
        }
    }
    
    fileprivate func showSearchChaptersViewController() {
        presentViewController(R.storyboard.search.searchChaptersViewController()!.apply {
            $0.chapters = chapters
            $0.chapterSelectedHandler = { [weak self] chapter in
                self?.addChapterFilter(chapter)
            }
        })
    }
    
    fileprivate func addBookFilter(_ book: Book) {
        
        let vmBook = searchViewModel.selectedBook
        
        if vmBook?.id != book.id {
            filtersContentStackView.removeAllArrangedSubviews()
            chapterDropdownView.placeholderText = "Choose Chapter"
            searchViewModel.getBookChapters(book, showChapterReferences: false)
            let filterView = FilterView().apply {
                $0.text = book.bookName
                $0.removeFilterHandler = removeBookFilter
            }
            bookDropdownView.text = book.name
            filtersContentStackView.addArrangedSubview(filterView)
            filtersContainerStackView.showView()
        }
        
    }
    
    fileprivate func removeBookFilter() {
        searchViewModel.selectedBook = nil
        searchViewModel.selectedChapter = nil
        filtersContentStackView.removeAllArrangedSubviews()
        filtersContainerStackView.hideView()
        bookDropdownView.placeholderText = "Choose Book"
        chapterDropdownView.placeholderText = "Choose Chapter"
    }
    
    fileprivate func addChapterFilter(_ chapter: Chapter) {
        let vmChapter = searchViewModel.selectedChapter
        
        if vmChapter?.id != chapter.id {
            removeChapterFilter()
            searchViewModel.selectedChapter = chapter
            let chapterText = "Chapter \(chapter.chapterNumber)"
            let filterView = FilterView().apply {
                $0.text = chapterText
                $0.removeFilterHandler = removeChapterFilter
            }
            chapterDropdownView.text = chapterText
            filtersContentStackView.addArrangedSubview(filterView)
        }
    }
    
    fileprivate func removeChapterFilter() {
        searchViewModel.selectedChapter = nil
        filtersContentStackView.removeAllArrangedSubviews()
        let bookFilterView = FilterView().apply {
            $0.text = searchViewModel.selectedBook!.bookName
            $0.removeFilterHandler = removeBookFilter
        }
        filtersContentStackView.addArrangedSubview(bookFilterView)
    }
    
    fileprivate func configureSearchBar() {
        searchBar.font = .comfortaaMedium(size: 15)
    }
    
    fileprivate func setupSearchResultsTableView() {
        
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeShowReferenceSegment()
    }
    
    fileprivate func observeShowReferenceSegment() {
        searchViewModel.showReferenceSegment.bind { [weak self] segment in
            if segment == .books {
                self?.showSearchBooksViewController()
            } else {
                self?.showSearchChaptersViewController()
            }
        }.disposed(by: disposeBag)
    }

}
