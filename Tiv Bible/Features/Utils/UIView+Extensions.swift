//
//  View+Extensions.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIView Inspectables
extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func addTapGesture(action: @escaping () -> Void ){
        let tap = UIViewTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: UIViewTapGestureRecognizer) {
        sender.action!()
    }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
      }
    
    func addDropShadow(color: UIColor = .darkGray, opacity: Float = 0.5, offSet: CGSize = CGSize(width: -1, height: 1), radius: CGFloat = 5, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addCornerRadius(radius: CGFloat = 5, maskToBounds: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = maskToBounds
    }
    
    func animateOnClick(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.5
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 1
                completion?()
            })
        }
    }
    
    func hideView() {
        isHidden = true
    }
    
    func showView(_ show: Bool = true) {
        isHidden = !show
    }
    
    func animateView(duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.5
        }) { completed in
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1
                completion?()
            })
        }
    }
    
    func animateViewOnTapGesture(duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        addTapGesture {
            self.animateView(duration: duration, completion: completion)
        }
    }
    
    func addDismissGesture(on viewcontroller: UIViewController, duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        animateViewOnTapGesture(duration: duration) {
            viewcontroller.dismissViewController(completion: completion)
        }
    }
    
    func addPopGesture(on viewcontroller: UIViewController) {
        animateViewOnTapGesture {
            viewcontroller.popViewController()
        }
    }
    
    enum ViewSide {
        case left, right, top, bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color.cgColor

        switch side {
        case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }

        layer.addSublayer(border)
    }
    
    func enableUserInteraction() {
        isUserInteractionEnabled = true
    }
    
    func disableUserInteraction() {
        isUserInteractionEnabled = false
    }
    
}

//MARK: - Custom UIViewTapGestureRecognizer
class UIViewTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}

// MARK: - UIView Extensions + Programmatic Constraint Anchors

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0,
                left: NSLayoutXAxisAnchor? = nil,
                paddingLeft: CGFloat = 0,
                right: NSLayoutXAxisAnchor? = nil,
                paddingRight: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func equalWidth(with item: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: item,
                                            attribute: .width,
                                            multiplier: multiplier,
                                            constant: constant)
        item.addConstraint(constraint)
    }
    
    func centerHorizontally(with item: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: item,
                                            attribute: .centerX,
                                            multiplier: multiplier,
                                            constant: constant)
        item.addConstraint(constraint)
    }
    
    func centerVertically(with item: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerY,
                                            relatedBy: .equal,
                                            toItem: item,
                                            attribute: .centerY,
                                            multiplier: multiplier,
                                            constant: constant)
        item.addConstraint(constraint)
    }
    
    func removeAllConstraints() {
        var _superview = self.superview

        while let superview = _superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            _superview = superview.superview
        }

        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}

// MARK: - UICollectionView Extensions

extension UICollectionView {

    func setNoValuesFoundBackgroundMessage(_ message: String = AppConstants.DATA_NOT_FOUND) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = .comfortaaLight()
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func removeBackgroundView() {
        self.backgroundView = nil
    }
}

// MARK: - UITableView Extensions

extension UITableView {

    func setNoValuesFoundBackgroundMessage(_ message: String = AppConstants.DATA_NOT_FOUND, separatorStyle: UITableViewCell.SeparatorStyle = .none) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .comfortaaLight()
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.isScrollEnabled = false
        self.separatorStyle = separatorStyle
    }

    func removeBackgroundView(separatorStyle: UITableViewCell.SeparatorStyle = .none) {
        self.backgroundView = nil
        self.isScrollEnabled = true
        self.separatorStyle = separatorStyle
    }
}

//MARK: UIImageView Extensions

extension UIImageView {

    func rounded(borderColor: UIColor = #colorLiteral(red: 0.4819999933, green: 0.7329999804, blue: 0.3689999878, alpha: 1), borderWidth: Float = 2) {
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
}

extension Array where Element == UIView {
    func addClearBackground() {
        forEach { $0.backgroundColor = .clear }
    }
    
    func hideViews() {
        forEach { $0.hideView() }
    }
    
    func showViews() {
        forEach { $0.showView() }
    }
    
    func disableUserInteraction() {
        forEach { $0.disableUserInteraction() }
    }
    
    func enableUserInteraction() {
        forEach { $0.enableUserInteraction() }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        forEach { $0.roundCorners(corners, radius: radius) }
    }
}
