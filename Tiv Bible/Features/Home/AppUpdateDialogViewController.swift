//
//  AppUpdateDialogViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 03/09/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class AppUpdateDialogViewController: UIViewController {
    
    @IBAction func updateNowButtonTapped(_ sender: Any) {
        openURL(url: AppConstants.APPSTORE_LINK)
    }
    
}
