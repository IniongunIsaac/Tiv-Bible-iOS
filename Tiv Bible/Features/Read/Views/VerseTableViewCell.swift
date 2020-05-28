//
//  VerseTableViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 28/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class VerseTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var verseTextLabel: UILabel!
    
    func configureView(verse: Verse) {
        titleLabel.isHidden = !verse.hasTitle
        titleLabel.text = verse.title
        
        let text = "\(verse.number). \(verse.text)"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.firstLineHeadIndent = 10.0
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.comfortaaRegular(size: 15),
            .paragraphStyle: paragraphStyle
        ]

        let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        attributedText.addAttribute(.font, value: UIFont.comfortaaBold(size: 13), range: NSRange(location: 0, length: "\(verse.number)".count + 1))
        verseTextLabel.attributedText = attributedText
    }
}
