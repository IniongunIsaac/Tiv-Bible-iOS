//
//  NoteTableViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var referenceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var verseTextLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func configureView(note: Note) {
        note.do {
            referenceLabel.text = $0.bookNameAndChapterNumberAndVerseNumbersString
            dateLabel.text = $0.dateString
            verseTextLabel.text = $0.formattedVersesText
            commentLabel.text = $0.comment
        }
    }

}
