//
//  UIViewController+Extensions.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 02/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit
import Alertift
import PopupDialog
import Toast_Swift

extension UIViewController {
    
    func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    func showDialog(for viewController: UIViewController, opacity: CGFloat = 0.1, dismissCompletionHandler: (() -> Void)? = nil) {
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius = Float(10)
        
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.opacity = opacity
        
        let popupDialog = PopupDialog(viewController: viewController, transitionStyle: .bounceUp, completion: dismissCompletionHandler)
        present(popupDialog, animated: true, completion: nil)
    }
    
    func setViewControllers(with viewController: UIViewController, animate: Bool = false) {
        navigationController?.setViewControllers([viewController], animated: animate)
    }
    
    func pushViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func popToRootViewController(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func dismissViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
    
    func presentViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(viewController, animated: animated, completion: completion)
    }
    
    func showHome(animate: Bool = false) {
        setViewControllers(with: R.storyboard.homeTabs.instantiateInitialViewController()!)
    }
    
    func hideNavBar(_ shouldHide: Bool = true) {
        self.navigationController?.navigationBar.isHidden = shouldHide
    }
    
    func share(content: Any) {
        let activityController = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        activityController.excludedActivityTypes = [.print, .saveToCameraRoll, .assignToContact, .addToReadingList, .airDrop]
        activityController.popoverPresentationController?.sourceView = view
        present(activityController, animated: true)
    }
    
    func enableSwipeBackToPopGesture(_ enable: Bool = true) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = enable
    }
    
    func disableNavBar() {
        navigationController?.navigationBar.subviews.disableUserInteraction()
    }
    
    func enableNavBar() {
        navigationController?.navigationBar.subviews.enableUserInteraction()
    }
    
    func setApplicationRootViewController(_ viewController: UIViewController) {
        UIApplication.shared.windows.first?.do {
            $0.rootViewController = viewController
            $0.makeKeyAndVisible()
        }
    }
    
    func showTabBar(_ show: Bool = true) {
        tabBarController?.tabBar.isHidden = !show
    }
    
    func showAlert(message: String, type: AlertType, duration: TimeInterval = 3.0, dismissCompletion: (() -> Void)? = nil) {
        runOnMainThread { [weak self] in
            self?.view.hideAllToasts()
        }
        var color: UIColor = .appGreen
        switch type {
        case .error:
            color = .appRed
        case .info:
            color = .appInfo
        case .success:
            color = .appGreen
        }
        
        var toastStyle = ToastStyle()
        toastStyle.messageColor = .white
        toastStyle.messageFont = .comfortaaRegular(size: 14)
        toastStyle.backgroundColor = color
        
        ToastManager.shared.isTapToDismissEnabled = true
        
        runOnMainThread { [weak self] in
            self?.view.makeToast(message, duration: duration, position: .top, style: toastStyle) { completed in
                dismissCompletion?()
            }
        }
    }
    
    func hideAlert() {
        runOnMainThread { [weak self] in
            self?.view.hideAllToasts()
        }
    }
    
    func navigateToTab(_ tabOption: TabOption) {
        tabBarController?.selectedIndex = tabOption.rawValue
    }
    
    func configureNavBar(title: String, barBgColor: UIColor = .primaryColor, barTextColor: UIColor = .white) {
        hideNavBar(false)
        self.title = title
        navigationController?.navigationBar.apply {
            $0.barTintColor = barBgColor
            $0.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.comfortaaSemiBold(size: 16)]
            $0.tintColor = barTextColor
        }
    }
    
    var width: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        UIScreen.main.bounds.height
    }
    
}
