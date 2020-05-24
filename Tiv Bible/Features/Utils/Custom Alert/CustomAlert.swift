//
//  CustomAlert.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit

class CustomAlert {
    var messageLbl: UILabel!
    var cancelButton: UIButton!
    var messageContainerView: UIView!
    let parentView: UIView
    var dismissCompletion: (() -> Void)? = nil
    
    init(on parentView: UIView) {
        self.parentView = parentView
    }
    
    func showAlert(text: String, type: AlertType, dismissCompletion: (() -> Void)? = nil) {
        
        self.dismissCompletion = dismissCompletion
        
        hideAlert()
        
        runOnMainThread { [weak self] in
            
            guard let self = self else { return }
            
            self.messageContainerView?.alpha = 1
            
            if self.messageContainerView == nil {
                self.messageLbl = UILabel()
                self.messageLbl.textAlignment = .center
                self.messageLbl.numberOfLines = 0
                self.messageLbl.adjustsFontSizeToFitWidth = true
                self.messageLbl.minimumScaleFactor = 0.8
                self.messageLbl.font = .comfortaaRegular(size: 16)
                self.messageLbl.setContentHuggingPriority(.defaultLow, for: .vertical)
                self.messageLbl.setContentHuggingPriority(.defaultLow, for: .horizontal)
                self.messageLbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                self.messageLbl.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
                
                self.cancelButton = UIButton(type: .close)
                self.cancelButton.tintColor = .label
                self.cancelButton.addTarget(self, action: #selector(self.hideAlert), for: .touchUpInside)
                self.cancelButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
                self.cancelButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                
                self.messageContainerView = UIView(frame: CGRect(x: 0, y: -60, width: self.parentView.frame.width, height: 80))
                
                self.messageContainerView.addSubview(self.messageLbl)
                self.messageContainerView.addSubview(self.cancelButton)
                
                self.messageLbl.anchor(top: self.messageContainerView.topAnchor, paddingTop: 10, bottom: self.messageContainerView.bottomAnchor, paddingBottom: 5, left: self.messageContainerView.leftAnchor, paddingLeft: 8, right: self.cancelButton.leftAnchor, paddingRight: 5, height: self.messageContainerView.frame.height - 15)
                
                self.cancelButton.anchor(bottom: self.messageContainerView.bottomAnchor, paddingBottom: 10, left: self.messageLbl.rightAnchor, paddingLeft: 10, right: self.messageContainerView.rightAnchor, paddingRight: 8, width: 35, height: 35)
                
                let currentWindow: UIWindow? = UIApplication.shared.keyWindow
                currentWindow?.addSubview(self.messageContainerView)
            }
            
            switch type {
            case .success:
                self.messageContainerView.backgroundColor = .systemGreen
                self.messageLbl.textColor = .white
            case .error:
                self.messageContainerView.backgroundColor = .systemRed
                self.messageLbl.textColor = .white
            default:
                self.messageContainerView.backgroundColor = .systemGray2
                self.messageLbl.textColor = .label
            }
            
            self.messageLbl.text = "\n\n\(text)\n\n"
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 6, options: [], animations: ({
                self.messageContainerView.frame.origin.y = 0
            }), completion: nil)
            
        }
    }
    
    @objc func hideAlert() {
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.messageContainerView?.frame.origin.y = -60
            self?.messageContainerView?.alpha = 0
        }) { [weak self] completed in
            if completed {
                self?.dismissCompletion?()
            }
        }
        
    }
    
}
