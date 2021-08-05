//
//  Font+Extensions.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit

func printAvailableFonts() {
    UIFont.familyNames.forEach({ familyName in
        let fontNames = UIFont.fontNames(forFamilyName: familyName)
        print(familyName, fontNames)
    })
}

extension UIFont {
    
    class func comfortaaRegular(size: CGFloat = 16) -> UIFont { R.font.comfortaaRegular(size: size)! }
    
    class func comfortaaMedium(size: CGFloat = 16) -> UIFont { R.font.comfortaaMedium(size: size)! }
    
    class func comfortaaBold(size: CGFloat = 16) -> UIFont { R.font.comfortaaBold(size: size)! }
    
    class func comfortaaLight(size: CGFloat = 16) -> UIFont { R.font.comfortaaLight(size: size)! }
    
    class func comfortaaSemiBold(size: CGFloat = 16) -> UIFont { R.font.comfortaaBold(size: size)! }
    
}
