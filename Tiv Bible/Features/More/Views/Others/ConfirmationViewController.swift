//
//  ConfirmationViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    @IBOutlet weak var promptLabel: UILabel!
    
    var confirmationHandler: NoParamHandler?
    var prompt: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let prompt = prompt {
            promptLabel.text = prompt
        }
    }

    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismissViewController()
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        dismissViewController { [weak self] in
            self?.confirmationHandler?()
        }
    }
    
}
