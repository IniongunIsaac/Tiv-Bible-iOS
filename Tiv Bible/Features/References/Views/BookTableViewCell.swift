//
//  BookTableViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    func configureView(book: Book) {
        book.do {
            bookNameLabel.text = $0.bookName
            activate($0.isSelected)
        }
    }
    
    fileprivate func activate(_ activate: Bool) {
        checkmarkImageView.showView(activate)
        detailsView.backgroundColor = activate ? UIColor.accentColor!.withAlphaComponent(0.2) : .clear
        bookNameLabel.textColor = activate ? .accentColor : .aLabel
    }
    
}
