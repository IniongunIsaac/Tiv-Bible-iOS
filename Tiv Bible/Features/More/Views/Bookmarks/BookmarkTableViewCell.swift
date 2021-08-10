//
//  BookmarkTableViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var referenceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var verseTextLabel: UILabel!
    
    func configureView(bookmark: Bookmark) {
        bookmark.do {
            referenceLabel.text = $0.bookNameAndChapterNumberAndVerseNumberString
            verseTextLabel.text = $0.verse?.text
            dateLabel.text = $0.dateString
        }
    }
    
}
