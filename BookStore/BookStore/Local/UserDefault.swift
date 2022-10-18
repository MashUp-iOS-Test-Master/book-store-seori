//
//  UserDefault.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    private let userDefaults: UserDefaults
    private let key: String
    private let defaultValue: Value
    
    var wrappedValue: Value {
        get { userDefaults.object(forKey: self.key) as? Value ?? defaultValue }
        set { userDefaults.set(newValue, forKey: self.key) }
    }
    
    init(key: String, defaultValue: Value) {
        userDefaults = .standard
        self.key = key
        self.defaultValue = defaultValue
    }
}


extension UserDefaults {
    @UserDefault(key: "books", defaultValue: [])
    static var books: [BookModel]
}
