//
//  UIColor+Extension.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 25/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(_ hexString: String, alpha: CGFloat = 1.0) {
      var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

      if (cString.hasPrefix("#")) { cString.removeFirst() }

      if ((cString.count) != 6) {
        self.init("ff0000") // return red color for wrong hex input
        return
      }

      var rgbValue: UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)

      self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha)
    }
    
    static var primaryColor: UIColor {
        return UIColor("#008577")
    }
    
}
