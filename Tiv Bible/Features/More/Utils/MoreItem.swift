//
//  MoreItem.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 10/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit

enum MoreItem: String, CaseIterable, Scopable {
    case bookmarks = "Bookmarks", highlights = "Highlights", notes = "Notes", history = "History", apostlesCreed = "Akar a Puekarahar", commandments = "Atindi a Pue", lordsPrayer = "Msen U Terwase", share = "Share with friends", rating = "Rate on Appstore", settings = "Settings"
    
    var icon: UIImage? {
        switch self {
        case .bookmarks:
            return R.image.bookmark_icon()
        case .highlights:
            return R.image.highlight()
        case .notes:
            return R.image.notes_icon()
        case .history:
            return R.image.history_icon()
        case .apostlesCreed:
            return R.image.book_icon()
        case .commandments:
            return R.image.book_icon()
        case .lordsPrayer:
            return R.image.book_icon()
        case .share:
            return R.image.share_icon()
        case .rating:
            return R.image.star_icon()
        case .settings:
            return R.image.gear_icon()
        }
    }
}
