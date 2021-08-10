//
//  TapActionTableViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class TapActionTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var rightIconImageView: UIImageView!
    
    func configureView(action: TapAction) {
        action.do {
            iconImageView.image = $0.icon
            itemLabel.text = $0.rawValue
        }
        
        if [.delete, .dismiss].contains(action) {
            detailsView.backgroundColor = .appRed.withAlphaComponent(0.1)
            itemLabel.textColor = .appRed
            iconImageView.tintColor = .appRed
            rightIconImageView.tintColor = .appRed
        }
    }

}
