//
//  Code+Extensions.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 24/05/2020.
//  Copyright © 2020 Iniongun Group. All rights reserved.
//

import Foundation
import UIKit
import DeviceKit
import RxSwift

typealias NoParamHandler = (() -> Void)
let currentDevice = Device.current

func runAfter(_ delay: Double = 2.0, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
        action()
    }
}

func runOnMainThread(action: @escaping () -> Void) {
    DispatchQueue.main.async {
        action()
    }
}

func runOnBackgroundThread(action: @escaping () -> Void) {
    DispatchQueue.global().async {
        action()
    }
}

func runOnLabeledBackgroundThread(action: @escaping () -> Void) {
    DispatchQueue(label: AppConstants.BACKGROUND_THREAD_LABEL, qos: .background) .async {
        action()
    }
}

func runOnBackgroundThenMainThread(action: @escaping () -> Void) {
    DispatchQueue.global().async {
        runOnMainThread {
            action()
        }
    }
}

func animateView(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }, codeToAnimate: @escaping () -> Void) {
    UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        codeToAnimate()
    }, completion: completion)
}

func randomString(length: Int = 11) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

extension Set {
    var toArray: [Element] {
        return Array(self)
    }
}

extension Collection {
    func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}

extension String {
    func chunkFormatted(withChunkSize chunkSize: Int = 4, withSeparator separator: Character = " ") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize).map{ String($0) }.joined(separator: String(separator))
    }
    
    func formatWith234() -> String {
        var value = self
        value.replaceSubrange(value.startIndex...value.startIndex, with: "+234")
        return value
    }
    
    var remove234: String {
        return self.replacingOccurrences(of: "+234", with: "0")
    }
    
    var orDash: String {
        return self.isEmpty ? "-" : self
    }
    
    var orEmpty: String {
        return self.isEmpty ? "" : self
    }
    
    func copyToClipboard() {
        UIPasteboard.general.string = self
    }
    
}

func restrictTextfieldToDigitsWithMaximumLength(textField: UITextField, range: NSRange, string: String, maxLength: Int) -> Bool {
    // get the current text, or use an empty string if the failed
    let currentText = textField.text ?? ""

    // attempt to read the range they are trying to change, or exit if we can't
    guard let stringRange = Range(range, in: currentText) else { return false }

    // add their new text to the existing text
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    
    //  make sure the result is under `maxLength` characters and remove non-numerics and compare with original string
    return string == string.filter("0123456789".contains) && updatedText.count <= maxLength
    
}

//MARK: - Substrings
extension String {
    
    subscript (start: Int, end: Int) -> Substring {
        let startPos = index(startIndex, offsetBy: start)
        let endPos: String.Index
        if end > 0 {
            endPos = index(startIndex, offsetBy: end)
        } else {
            endPos = index(endIndex, offsetBy: end)
        }
        return self[startPos...endPos]
    }
    
    subscript (pos: Int) -> Character {
        if pos > 0 {
            return self[index(startIndex, offsetBy: pos)]
            
        }
        return self[index(endIndex, offsetBy: pos)]
    }
    
}

//MARK: - Current Date Year and Month

func currentYear() -> String {
    let date = Date()
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: date) // gets current year (i.e. 2017)
    
    return "\(currentYear)"
}

func currentMonth() -> String {
    let date = Date()
    let calendar = Calendar.current
    let currentMonth = calendar.component(.month, from: date) // gets current month (i.e. 10)
    
    return "\(currentMonth)"
}

func currentYearFirstTwoDigits() -> Int {
    return Int(currentYear()[0,1])!
}

func currentYearLastTwoDigits() -> Int {
    return Int(currentYear()[2,3])!
}

extension Collection where Iterator.Element == Int {
    var seatsString: String {
        return String(describing: self.compactMap { $0 }).replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
    }
}

extension Data {
    var mbSize: Float {
        return Float(Float(self.count) / 1048576.0)
    }
}

extension UIApplication {

  func setRootViewController(_ vc : UIViewController){

      self.windows.first?.rootViewController = vc
      self.windows.first?.makeKeyAndVisible()

    }
}

extension Sequence {
    func distinctBy<A: Hashable>(by selector: (Iterator.Element) -> A) -> [Iterator.Element] {
        var set: Set<A> = []
        var list: [Iterator.Element] = []

        forEach { e in
            let key = selector(e)
            if set.insert(key).inserted {
                list.append(e)
            }
        }

        return list
    }
}

extension Collection {
    var isNotEmpty: Bool { !self.isEmpty }
    
    var asObservable: Observable<[Element]> { Observable.just(self as! [Self.Element]) }
}

extension Optional {
    var isNil : Bool {
        self == nil
    }
    
    var isNotNil : Bool {
        self != nil
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        self?.isEmpty ?? true ? "" : self!
    }
    
    var described: String {
        String(describing: self)
    }
}

func openURL(url: String) {
    if let url = URL(string: url) {
        UIApplication.shared.open(url)
    }
}

func canOpenURL(url: String) -> Bool {
    if let url = URL(string: url) {
        return UIApplication.shared.canOpenURL(url)
    }
    return false
}

func keepDeviceAwake(_ keepAwake: Bool) {
    UIApplication.shared.isIdleTimerDisabled = keepAwake
}
