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
    @IBOutlet weak var separatorView: UIView!
    
    func configureView(book: Book) {
        book.do {
            bookNameLabel.text = $0.bookName
            //checkmarkImageView.showView($0.isSelected)
        }
    }
    
}
