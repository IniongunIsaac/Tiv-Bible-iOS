//
//  NumberCollectionViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class ChapterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberView: NumberView!
    
    func configureView(chapter: Chapter) {
        numberView.do {
            $0.addClearBackground()
            $0.text = chapter.chapterNumber.string
            $0.activate(chapter.isSelected)
        }
    }
    
}
