//
//  SearchBooksViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 09/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import BottomPopup
import RxSwift

class SearchBooksViewController: BottomPopupViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var booksTableView: UITableView!

    fileprivate let disposeBag = DisposeBag()
    var books = [Book]()
    var bookSelectedHandler: ((Book) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    fileprivate func configureViews() {
        searchBar.font = .comfortaaMedium(size: 14)
        setupBooksTableView()
    }
    
    fileprivate func setupBooksTableView() {
        let rxSearchText = searchBar.rx.text.orEmpty.distinctUntilChanged()
        
        books.asObservable.map({ $0.isEmpty }).distinctUntilChanged().bind(to: booksTableView.rx.isEmpty(message: "Books will be shown here!")).disposed(by: disposeBag)
        
        Observable.combineLatest(books.asObservable, rxSearchText) { books, searchText -> [Book] in
            guard searchText.isNotEmpty else { return books }
            
            return books.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
            
        }.bind(to: booksTableView.rx.items(cellIdentifier: R.reuseIdentifier.searchBookTableViewCell.identifier, cellType: BookTableViewCell.self)) { index, book, cell in
            
            cell.configureView(book: book)
            
            cell.animateViewOnTapGesture { [weak self] in
                self?.handleBookSelected(book)
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleBookSelected(_ book: Book) {
        book.isSelected = true
        books.filter { $0.id != book.id }.forEach { $0.isSelected = false }
        booksTableView.reloadData()
        dismissViewController { [weak self] in
            self?.bookSelectedHandler?(book)
        }
    }
    
    override var popupHeight: CGFloat { height - 200 }
    
    override var popupTopCornerRadius: CGFloat { 20 }

}
