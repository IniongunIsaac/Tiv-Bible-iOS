//
//  ReadViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 26/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import UIKit

class ReadViewController: BaseViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bookChapterStackView: UIStackView!
    @IBOutlet weak var bookChapterLabel: UILabel!
    @IBOutlet weak var fontStyleButton: UIButton!
    @IBOutlet weak var versesTableView: UITableView!
    
    var readViewModel: IReadViewModel!
    
    override func getViewModel() -> BaseViewModel {
        return readViewModel as! BaseViewModel
    }
    
    override func addProgressBarConstraints() {
        mProgressBar.anchor(top: topView.bottomAnchor, paddingTop: 2, left: view.leftAnchor, right: view.rightAnchor, width: view.bounds.width, height: 3)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setTapGestures()
    }
    
    fileprivate func setTapGestures() {
        bookChapterStackView.addTapGesture { [weak self] in
            self?.bookChapterStackView.animateOnClick(completion: {
                
            })
        }
    }
    
    @IBAction func fontStyleButtonTapped(_ sender: UIButton) {
        
    }
    
}
