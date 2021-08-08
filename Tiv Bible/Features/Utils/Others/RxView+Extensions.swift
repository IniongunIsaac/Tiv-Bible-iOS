//
//  RxView+Extensions.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    func isEmpty(message: String? = AppConstants.DATA_NOT_FOUND) -> Binder<Bool> {
        return Binder(base) { tableView, isEmpty in
            if isEmpty {
                tableView.setNoValuesFoundBackgroundMessage(message)
            } else {
                tableView.removeBackgroundView()
            }
        }
    }
}

extension Reactive where Base: UICollectionView {
    func isEmpty(message: String? = AppConstants.DATA_NOT_FOUND) -> Binder<Bool> {
        return Binder(base) { collectionView, isEmpty in
            if isEmpty {
                collectionView.setNoValuesFoundBackgroundMessage(message)
            } else {
                collectionView.removeBackgroundView()
            }
        }
    }
}
