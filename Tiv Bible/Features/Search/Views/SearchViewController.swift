//
//  SearchViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit
import RxSwift

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
            
            search()
        }
        
    }
    
    fileprivate func removeBookFilter() {
        searchViewModel.selectedBook = nil
        searchViewModel.selectedChapter = nil
        filtersContentStackView.removeAllArrangedSubviews()
        filtersContainerStackView.hideView()
        bookDropdownView.placeholderText = "Choose Book"
        chapterDropdownView.placeholderText = "Choose Chapter"
        search()
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
            search()
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
        search()
    }
    
    fileprivate func search() {
        if let text = searchBar.text, text.isNotEmpty {
            searchViewModel.search(text: text)
        }
    }
    
    fileprivate func configureSearchBar() {
        searchBar.font = .comfortaaMedium(size: 15)
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                self?.search()
            }.disposed(by: disposeBag)
    }
    
    fileprivate func setupSearchResultsTableView() {
        searchViewModel.verses.map({ $0.isEmpty }).distinctUntilChanged().bind(to: searchResultsTableView.rx.isEmpty(message: "Search results will be shown here!")).disposed(by: disposeBag)
        
        searchViewModel.verses.bind(to: searchResultsTableView.rx.items(cellIdentifier: R.reuseIdentifier.searchResultTableViewCell.identifier, cellType: SearchResultTableViewCell.self)) { index, verse, cell in
            
            cell.configureView(verse: verse)
            
            cell.animateViewOnTapGesture { [weak self] in
                self?.searchViewModel.handleVerseSelected(verse)
            }
            
        }.disposed(by: disposeBag)
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeShowReferenceSegment()
        observeShowReadView()
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
    
    fileprivate func observeShowReadView() {
        searchViewModel.showReaderView.bind { [weak self] show in
            if show {
                self?.navigateToTab(.read)
            }
        }.disposed(by: disposeBag)
    }

}
