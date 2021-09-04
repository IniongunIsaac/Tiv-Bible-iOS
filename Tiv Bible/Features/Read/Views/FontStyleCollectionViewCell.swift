//
//  FontStyleCollectionViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 29/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class FontStyleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fontStyleView: ViewWithBorderAttributes!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var fontStyleTextLabel: UILabel!
    
    func configureView(font: FontStyle, settings: Setting) {
        fontStyleView.cornerRadius = (currentDevice.isPad ? 28 : 18).cgfloat
        font.do {
            fontStyleTextLabel.text = $0.name
            checkmarkImageView.showView($0.id == settings.fontStyle!.id)
        }
    }
}
