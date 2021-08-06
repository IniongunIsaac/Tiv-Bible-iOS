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
    
    func configureView(verse: Verse, settings: Setting) {
        titleLabel.isHidden = !verse.hasTitle
        titleLabel.text = verse.title
        
        let text = "\(verse.number). \(verse.text)"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = settings.lineSpacing.cgfloat
        paragraphStyle.firstLineHeadIndent = 10
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.comfortaaRegular(size: settings.fontSize.cgfloat),
            .paragraphStyle: paragraphStyle
        ]

        let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        attributedText.addAttribute(.font, value: UIFont.comfortaaBold(size: settings.fontSize.cgfloat), range: NSRange(location: 0, length: "\(verse.number)".count + 1))
        
        if verse.isSelected {
            attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.patternDashDot.rawValue | NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedText.length))
        }
        
        verseTextLabel.attributedText = attributedText
        
        verse.do {
            if $0.isHighlighted {
                verseTextLabel.backgroundColor = UIColor($0.highlight!.color!.hexCode)
            } else {
                verseTextLabel.backgroundColor = .clear
            }
        }
        
    }
}
