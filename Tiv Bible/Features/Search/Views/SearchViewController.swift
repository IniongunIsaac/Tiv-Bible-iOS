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
                self?.searchViewModel.getBookChapters(book, showChapterReferences: false)
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
                self?.searchViewModel.handleChapterSelected(chapter)
                self?.addChapterFilter(chapter)
            }
        })
    }
    
    fileprivate func addBookFilter(_ book: Book) {
        
    }
    
    fileprivate func addChapterFilter(_ chapter: Chapter) {
        
    }
    
    fileprivate func configureSearchBar() {
        searchBar.font = .comfortaaMedium(size: 15)
    }
    
    fileprivate func setupSearchResultsTableView() {
        
    }

}
