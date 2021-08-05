//
//  ScopeFunctions.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 03/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation

protocol Scopable {}

extension Scopable {
    
    @discardableResult @inline(__always) func apply(block: (Self) -> ()) -> Self {
        block(self)
        return self
    }
    
    @inline(__always) func `do`(block: (Self) -> ()) {
        block(self)
    }
    
    @inline(__always) func `let`<R>(block: (Self) -> R) -> R {
        return block(self)
    }
    
    @inline(__always) func also(block: (Self) -> ()) -> Self {
        block(self)
        return self
    }
    
    @inline(__always) func takeIf(predicate: (Self) -> Bool) -> Self? {
        if (predicate(self)) {
            return self
        } else {
            return nil
        }
    }
    
    @inline(__always) func takeUnless(predicate: (Self) -> Bool) -> Self? {
        if (!predicate(self)) {
            return self
        } else {
            return nil
        }
    }
    
    @inline(__always) func `repeat`(times: Int, action: (Int) -> ()) -> () {
        for index in (0...times-1) {
            action(index)
        }
    }
}

extension NSObject: Scopable {}

extension String: Scopable {}

@discardableResult func with<T>(_ it: T, f:(T) -> ()) -> T {
    f(it)
    return it
}
