//
//  HighlightTableViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class HighlightTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var referenceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var verseTextLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    func configureView(highlight: Highlight) {
        highlight.do {
            referenceLabel.text = $0.bookNameAndChapterNumberAndVerseNumberString
            dateLabel.text = $0.dateString
            verseTextLabel.text = $0.verse?.text
            colorView.backgroundColor = UIColor($0.color!.hexCode)
        }
    }

}
