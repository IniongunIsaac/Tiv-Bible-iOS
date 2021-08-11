//
//  OthersViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 11/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import BottomPopup
import AttributedStringBuilder

class OthersViewController: BottomPopupViewController {

    @IBOutlet weak var otherTitleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var shareView: IconView!
    @IBOutlet weak var copyView: IconView!
    
    var other: Other!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetails()
        [shareView, copyView].addClearBackground()
        
        shareView.animateViewOnTapGesture { [weak self] in
            guard let self = self else { return }
            self.share(content: self.other.shareableContent)
        }
        
        copyView.animateViewOnTapGesture { [weak self] in
            self?.other.shareableContent.copyToClipboard()
            self?.showAlert(message: "Content copied!", type: .success)
        }
    }
    
    fileprivate func showDetails() {
        other.do {
            otherTitleLabel.attributedText = AttributedStringBuilder()
                .text("\($0.title)", attributes: [.font(.comfortaaBold(size: 17)), .underline(true), .textColor(.aLabel), .alignment(.center)]).attributedString
            subtitleLabel.text = $0.subTitle
            contentLabel.text = $0.text
        }
    }
    
    override var popupHeight: CGFloat { height - 200 }
    
    override var popupTopCornerRadius: CGFloat { 20 }

}
