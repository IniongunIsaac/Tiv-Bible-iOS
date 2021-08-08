//
//  IconView.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class IconView: BaseView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconImageViewWidthConstraint: NSLayoutConstraint!
    
    override var kContentView: UIView { contentView }
    override var nibName: String { R.nib.iconView.name }
    
    @IBInspectable var icon: UIImage? {
        get { iconImageView.image }
        set { iconImageView.image = newValue }
    }
    
    @IBInspectable var iconSize: Int = 35 {
        didSet {
            iconImageViewWidthConstraint.constant = iconSize.cgfloat
            iconImageViewWidthConstraint.constant = iconSize.cgfloat
        }
    }
    
    @IBInspectable var viewRadius: Int = 35 {
        didSet {
            detailsView.cornerRadius = viewRadius.cgfloat
        }
    }
    
}
