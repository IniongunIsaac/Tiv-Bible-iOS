//
//  NumberView.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class NumberView: BaseView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    override var kContentView: UIView { contentView }
    override var nibName: String { R.nib.numberView.name }
    
    @IBInspectable var text: String {
        get { textLabel.text.orEmpty }
        set { textLabel.text = newValue }
    }
    
    func activate(_ activate: Bool = true) {
        if activate {
            detailsView.backgroundColor = .accentColor
            textLabel.textColor = .aLabel
        } else {
            detailsView.backgroundColor = .aSecondarySystemBackground
            textLabel.textColor = .aSecondaryLabel
        }
    }

}
