//
//  MoreItemTableViewCell.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class MoreItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
        
    func configureView(item: MoreItem) {
        item.do {
            iconImageView.image = $0.icon
            itemLabel.text = $0.rawValue
        }
    }

}
