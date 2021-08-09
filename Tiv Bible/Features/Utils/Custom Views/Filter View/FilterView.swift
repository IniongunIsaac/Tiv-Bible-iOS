//
//  FilterView.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 09/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class FilterView: BaseView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var closeImageView: UIImageView!
    
    override var kContentView: UIView { contentView }
    override var nibName: String { R.nib.filterView.name }
    
    var text: String {
        get { textLabel.text.orEmpty }
        set { textLabel.text = newValue }
    }
    
    var removeFilterHandler: NoParamHandler?
    
    override func configureViews() {
        super.configureViews()
        closeImageView.animateViewOnTapGesture { [weak self] in
            self?.removeFilterHandler?()
        }
    }

}
