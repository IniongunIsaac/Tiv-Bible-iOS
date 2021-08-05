//
//  Preference+Utils.swift
//  Tiv Bible
//
//  Created by Isaac Iniongun on 02/08/2021.
//  Copyright © 2021 Iniongun Group. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultStorage<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    private let userDefaults: UserDefaults
    
    init(key: String, default: T, store: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = `default`
        self.userDefaults = store
    }
    
    var wrappedValue: T {
        get {
            guard let data = userDefaults.data(forKey: key) else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: key)
        }
    }
}
