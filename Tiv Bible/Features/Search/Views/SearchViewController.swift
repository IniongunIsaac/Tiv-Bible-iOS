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

    override func configureViews() {
        super.configureViews()
        hideNavBar()
        [bookDropdownView, chapterDropdownView].addClearBackground()
        filtersContainerStackView.hideView()
        configureSearchBar()
        setupSearchResultsTableView()
    }
    
    override func setupTapGestures() {
        super.setupTapGestures()
        
        bookDropdownView.animateViewOnTapGesture { [weak self] in
            
        }
        
        chapterDropdownView.animateViewOnTapGesture { [weak self] in
            
        }
    }
    
    fileprivate func configureSearchBar() {
        searchBar.font = .comfortaaMedium(size: 15)
    }
    
    fileprivate func setupSearchResultsTableView() {
        
    }

}
