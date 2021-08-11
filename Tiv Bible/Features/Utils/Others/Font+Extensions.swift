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
    
    class func andesRoundedRegular(size: CGFloat = 16) -> UIFont { R.font.andesRoundedW03Regular(size: size)! }
    
    class func andesRoundedBlack(size: CGFloat = 16) -> UIFont { R.font.andesRoundedW03Black(size: size)! }
    
    class func andesRoundedBold(size: CGFloat = 16) -> UIFont { R.font.andesRoundedW03Bold(size: size)! }
    
    class func andesRoundedBook(size: CGFloat = 16) -> UIFont { R.font.andesRoundedW03Book(size: size)! }
    
    class func andesRoundedExtraBold(size: CGFloat = 16) -> UIFont { R.font.andesRoundedW03ExtraBold(size: size)! }
    
    class func andesRoundedLight(size: CGFloat = 16) -> UIFont { R.font.andesRoundedW03Light(size: size)! }
    
    class func andesRoundedMedium(size: CGFloat = 16) -> UIFont { R.font.andesRoundedW03Medium(size: size)! }
    
    class func andesRoundedSemiBold(size: CGFloat = 16) -> UIFont { R.font.andesRoundedW03SemiBold(size: size)! }
    
    class func andesRoundedUltraLight(size: CGFloat = 16) -> UIFont { R.font.andesRoundedW03UltraLight(size: size)! }
    
    var bold: UIFont { with(traits: .traitBold) }
    
    var italic: UIFont { with(traits: .traitItalic) }
    
    var boldItalic: UIFont { with(traits: [.traitBold, .traitItalic]) }
    
    
    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        
        return UIFont(descriptor: descriptor, size: 0)
    }
    
}
