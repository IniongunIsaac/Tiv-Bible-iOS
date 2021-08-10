//
//  TapAction.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit

enum TapAction: String, CaseIterable, Scopable {
    case readFullChapter = "Read full chapter", share = "Share", copy = "Copy", delete = "Delete", dismiss = "Dismiss"
    
    var icon: UIImage? {
        switch self {
        case .readFullChapter:
            return R.image.book_icon()
        case .share:
            return R.image.share_icon()
        case .copy:
            return R.image.copy_icon()
        case .delete:
            return R.image.trash_icon()
        case .dismiss:
            return R.image.filled_close_icon()
        }
    }
}
