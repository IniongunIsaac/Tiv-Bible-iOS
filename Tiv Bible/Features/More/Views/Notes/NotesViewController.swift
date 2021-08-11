//
//  NotesViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class NotesViewController: BaseViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    var moreViewModel: IMoreViewModel!
    override func getViewModel() -> BaseViewModel { moreViewModel as! BaseViewModel }
    
    fileprivate var clearAllButton: UIButton {
        UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 30)).apply { btn in
            btn.title = "Clear All"
            btn.textColor = .appRed
            btn.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
            btn.font = .andesRoundedRegular(size: 14)
        }
    }

    override func configureViews() {
        super.configureViews()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: clearAllButton)
        setupNotesTableView()
        moreViewModel.getNotes()
    }
    
    @objc fileprivate func clearAllButtonTapped() {
        clearAllButton.animateView { [weak self] in
            self?.showConfirmationViewController(prompt: "Are you sure you want to delete all your notes?") { [weak self] in
                self?.moreViewModel.deleteAllNotes()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar(false)
        title = "Notes"
    }
    
    fileprivate func setupNotesTableView() {
        moreViewModel.notes.map({ $0.isEmpty }).distinctUntilChanged().bind(to: notesTableView.rx.isEmpty(message: "Notes will be shown here!")).disposed(by: disposeBag)
        
        moreViewModel.notes.bind(to: notesTableView.rx.items(cellIdentifier: R.reuseIdentifier.noteTableViewCell.identifier, cellType: NoteTableViewCell.self)) { index, note, cell in
            
            cell.configureView(note: note)
            
            cell.animateViewOnTapGesture { [weak self] in
                //self?.handleBookmarkSelected()
            }
            
        }.disposed(by: disposeBag)
    }

}
