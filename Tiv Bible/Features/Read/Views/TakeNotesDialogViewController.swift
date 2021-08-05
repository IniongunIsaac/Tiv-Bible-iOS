//
//  TakeNotesDialogViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 05/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit
import AttributedStringBuilder

class TakeNotesDialogViewController: UIViewController {

    @IBOutlet weak var selectedVersesLabel: UILabel!
    @IBOutlet weak var notesTextView: TextViewWithPlaceholder!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedVersesText = ""
    var saveNotesHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedVersesLabel.attributedText = AttributedStringBuilder()
            .text("Notes for: ", attributes: [.font(.comfortaaMedium(size: 15))])
            .text("\(selectedVersesText)", attributes: [.font(.comfortaaSemiBold(size: 16))])
            .attributedString
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismissViewController()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        dismissViewController { [weak self] in
            guard let self = self else { return }
            self.saveNotesHandler?(self.notesTextView.text)
        }
    }
    
}
