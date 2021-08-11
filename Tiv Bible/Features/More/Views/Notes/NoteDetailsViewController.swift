//
//  NoteDetailsViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 11/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import BottomPopup
import AttributedStringBuilder

class NoteDetailsViewController: BottomPopupViewController {
    
    @IBOutlet weak var selectedVersesLabel: UILabel!
    @IBOutlet weak var shareView: IconView!
    @IBOutlet weak var copyView: IconView!
    @IBOutlet weak var deleteView: IconView!
    @IBOutlet weak var versesTextLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var note: Note!
    var deleteNoteHandler: NoParamHandler?
    var readFullChapterHandler: NoParamHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    fileprivate func configureViews() {
        [shareView, copyView, deleteView].addClearBackground()
        setupTapGestures()
        showNoteDetails()
    }
    
    fileprivate func showNoteDetails() {
        note.do {
            selectedVersesLabel.attributedText = AttributedStringBuilder()
                .text("\($0.bookNameAndChapterNumberAndVerseNumbersString)", attributes: [.font(.comfortaaBold(size: 17)), .underline(true), .textColor(.aLabel)])
                .attributedString
            versesTextLabel.attributedText = $0.attributedFormattedVersesText
            commentLabel.text = $0.comment
        }
    }
    
    fileprivate func setupTapGestures() {
        shareView.animateViewOnTapGesture { [weak self] in
            guard let self = self else { return }
            self.share(content: self.note.shareableText)
        }
        
        copyView.animateViewOnTapGesture { [weak self] in
            self?.note.shareableText.copyToClipboard()
            self?.showAlert(message: "Notes Copied!", type: .success)
        }
        
        deleteView.animateViewOnTapGesture(completion: deleteNote)
    }
    
    fileprivate func deleteNote() {
        showConfirmationViewController(prompt: "Are you sure you want to delete note?") { [weak self] in
            self?.dismissViewController {
                self?.deleteNoteHandler?()
            }
        }
    }

    @IBAction func readFullChapterButtonTapped(_ sender: Any) {
        dismissViewController { [weak self] in
            self?.readFullChapterHandler?()
        }
    }
    
    override var popupHeight: CGFloat { height - 100 }
    
    override var popupTopCornerRadius: CGFloat { 20 }
    
}
