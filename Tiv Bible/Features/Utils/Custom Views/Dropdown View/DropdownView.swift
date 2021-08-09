//
//  DropdownView.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 09/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class DropdownView: BaseView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override var kContentView: UIView { contentView }
    override var nibName: String { R.nib.dropdownView.name }
    
    @IBInspectable var placeholderText: String = "Choose One" {
        didSet {
            textLabel.do {
                $0.text = placeholderText
                $0.textColor = .aPlaceholderText
            }
        }
    }
    
    var text: String {
        get { textLabel.text.orEmpty }
        set {
            textLabel.do {
                $0.text = newValue
                $0.textColor = .aLabel
            }
        }
    }
    
}
