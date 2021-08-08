//
//  Numbers+Extensions.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 06/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit

protocol FormattableNumeric: ExpressibleByIntegerLiteral {
    static func +(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Self) -> Self
}

extension FormattableNumeric {
    
    var localized: String {
        guard let number = self as? NSNumber else { return "NaN" }
        return number.description(withLocale: Locale.current)
    }
    
    var string: String { "\(self as! NSNumber)" }
    
    var double: Double? {
        Double(truncating: self as! NSNumber)
    }
    
    var float: Float? {
        Float(truncating: self as! NSNumber)
    }
    
    var cgfloat: CGFloat {
        CGFloat(truncating: self as! NSNumber)
    }
    
    var int: Int? {
        Int(truncating: self as! NSNumber)
    }
    
    func string(fractionDigits:Int) -> String {
        let formatter = NumberFormatter().apply {
            $0.minimumFractionDigits = fractionDigits
            $0.maximumFractionDigits = fractionDigits
        }
        return formatter.string(from: self as! NSNumber) ?? "\(self)"
    }
    
}

extension Int: FormattableNumeric {}
extension Int8: FormattableNumeric {}
extension Int16: FormattableNumeric {}
extension Int32: FormattableNumeric {}
extension Int64: FormattableNumeric {}
extension Float: FormattableNumeric {}
extension Double: FormattableNumeric {}
extension CGFloat: FormattableNumeric {}

extension Collection where Element: FormattableNumeric {
    
    var sum: Element { reduce(0,+) }
    
    var multiply: Element { reduce(1,*) }
}
