//
//  SearchResultTableViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 09/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var verseTextLabel: UILabel!
    @IBOutlet weak var referenceLabel: UILabel!
    
    func configureView(verse: Verse) {
        verse.do {
            verseTextLabel.text = $0.text
            referenceLabel.text = $0.bookNameChapterNumberVerseNumber
        }
    }

}
