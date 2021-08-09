//
//  VerseCollectionViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class VerseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberView: NumberView!
    
    func configureView(verse: Verse) {
        numberView.do {
            $0.addClearBackground()
            $0.text = verse.number.string
            $0.activate(verse.isSelected)
        }
    }
    
}