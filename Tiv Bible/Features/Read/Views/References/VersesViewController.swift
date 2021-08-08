//
//  VersesViewController.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 08/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import UIKit
import RxSwift

class VersesViewController: UIViewController {

    @IBOutlet weak var versesCollectionView: UICollectionView!
    
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
