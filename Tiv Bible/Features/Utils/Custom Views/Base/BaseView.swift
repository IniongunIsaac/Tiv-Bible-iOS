//
//  BaseView.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 07/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    var kContentView: UIView { preconditionFailure("BaseView subclass must provide a contentView") }
    
    var nibName: String { preconditionFailure("BaseView subclass must provide a nibName") }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        configureViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        kContentView.prepareForInterfaceBuilder()
    }
    
    fileprivate func commonInit() {
        loadFromNib()
        kContentView.frame = bounds
        kContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    fileprivate func loadFromNib() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(kContentView)
    }
    
    func configureViews() {}
    
}
