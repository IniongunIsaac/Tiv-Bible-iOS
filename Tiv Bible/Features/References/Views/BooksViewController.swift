//
//  BooksViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit
import RxSwift

class BooksViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var booksTableView: UITableView!
    
    fileprivate let disposeBag = DisposeBag()
    var books = [Book]()
    
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
            
        }.bind(to: booksTableView.rx.items(cellIdentifier: R.reuseIdentifier.bookTableViewCell.identifier, cellType: BookTableViewCell.self)) { index, book, cell in
            
              cell.configureView(book: book)
                
              cell.animateViewOnTapGesture { [weak self] in
                
              }
            
        }.disposed(by: disposeBag)
    }

}
