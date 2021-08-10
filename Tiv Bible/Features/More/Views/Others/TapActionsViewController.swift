//
//  TapActionsViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import BottomPopup
import RxSwift

class TapActionsViewController: BottomPopupViewController {

    @IBOutlet weak var actionsTableView: UITableView!
    
    fileprivate let disposeBag = DisposeBag()
    var actionChosenHandler: ((TapAction) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionsTableView()
    }
    
    fileprivate func setupActionsTableView() {
        TapAction.allCases.asObservable.bind(to: actionsTableView.rx.items(cellIdentifier: R.reuseIdentifier.tapActionTableViewCell.identifier, cellType: TapActionTableViewCell.self)) { index, action, cell in
            
            cell.configureView(action: action)
            
            cell.animateViewOnTapGesture { [weak self] in
                self?.handleActionSelected(action)
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func handleActionSelected(_ action: TapAction) {
        dismissViewController { [weak self] in
            self?.actionChosenHandler?(action)
        }
    }
    
    override var popupHeight: CGFloat { 450 }
    
    override var popupTopCornerRadius: CGFloat { 20 }

}
