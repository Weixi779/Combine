//
//  UserDefaultsStorage.swift
//  PokeMaster
//
//  Created by 孙世伟 on 2024/6/25.
//

import Foundation

@propertyWrapper
struct UserDefaultsStorage<T:Codable> {
    var value: T
    var defaultValue: T
    var key: String
    var userDefaults: UserDefaults = .standard
    
    init(defaultValue: T, key: String, userDefaults: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.userDefaults = userDefaults
        self.value = (userDefaults.value(forKey: self.key) as? T) ?? self.defaultValue
    }
    
    var wrappedValue: T {
        set {
            value = newValue
            userDefaults.setValue(value, forKey: key)
        }
        get { value }
    }
}
