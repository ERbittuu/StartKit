//
//  Defaults.swift
//  Defaults Source
//
//  Created by Utsav Patel on 2/5/19.
//  Copyright © 2019 erbittuu. All rights reserved.
//

import Foundation

/// An object oriented wrapper `UserDefaults`.
/// Initialize it like an `UserDefaults`.
/// See `Defaults.item(forKey:)` for getting and setting values.

public class Defaults: NSObject {

    /// The standard object for `UserDefaults.standard`
    public static let standard = Defaults()

    /// The `UserDefaults` instance associated with this object.
    private(set) public var userDefaults: UserDefaults

    /// Initialize for `UserDefaults.standard`.
    ///
    /// - Returns: `Defaults.standard`.
    public override init() {
        userDefaults = UserDefaults.standard
    }

    /// Initialize `UserDefaults` with given suite name.
    ///
    /// - Parameters:
    ///     - suiteName: The suite name passed to `UserDefaults(suiteName:)`.
    ///
    /// - Returns: An `Defaults` to be used with the `UserDefaults` initialized with given suite name.
    /// If `suiteName` is `nil`, it will return `Defaults.standard`
    public init?(suiteName: String? = nil) {
        if let suiteName = suiteName, let userDefaults = UserDefaults(suiteName: suiteName) {
            self.userDefaults = userDefaults
        } else if suiteName == nil {
            userDefaults = .standard
        } else {
            return nil
        }
    }

    // MARK: - Getters

    /// Use this method to get a representation of the item for the given key.
    ///
    /// - Parameters:
    ///     - key: Key used to set and get values.
    ///
    /// - Returns: A representation of the item for the given key. See `DefaultsItem` to set and get values.
    public func item<T>(forKey key: String, defaultValue: T) -> DefaultsItem<T> {
        return DefaultsItem<T>(key: key, fromUserDefaults: userDefaults, defaultValue: defaultValue)
    }

    /// Returns all items stored.
//    public var arrayRepresentation: [DefaultsItem] {
//        var items = [DefaultsItem]()
//        for (key, _) in userDefaults.dictionaryRepresentation() {
////            items.append(DefaultsItem(key: key, fromUserDefaults: userDefaults, type: AnyClass.Type))
//        }
//        return items
//    }
}

/// A class representing a value stored in `UserDefaults` or `Defaults`. The item can exist or not.
public class DefaultsItem<T>: NSObject {

    public override var description: String {
        return String(describing: value)
    }

    /// The key of the object in `UserDefaults`.
    private(set) public var key: String
    private(set) public var defaultValue: T
    private var userDefaults: UserDefaults

    internal init(key: String, fromUserDefaults userDefaults: UserDefaults, defaultValue: Any) {
        if let defaultValueConvert = defaultValue as? T {
            self.defaultValue = defaultValueConvert
        } else {
            if let fourceWrapRemove = T.self as? T {
                self.defaultValue = fourceWrapRemove
            } else {
                fatalError("This should not happen")
            }
            print("Code to set DefaultValue")
        }
        self.key = key
        self.userDefaults = userDefaults
    }

    // MARK: - Getters and Setters

    private func set(_ value: AnyObject) {

        userDefaults.set(value, forKey: key)
        print("Default<\(T.self)>[\(key)]: \(value)")
        userDefaults.synchronize()
    }

    /// Returns or sets the object associated with the specified key.
    ///
    /// - Returns: The object associated with the specified key, or `nil` if the key was not found.
    public var value: T {
        get {

            guard let valueX = userDefaults.value(forKey: key) as? T else {
                debugPrint("Error while getting value From Defaults")
                debugPrint("Returning defaultValue: @Default:\(key)->\(defaultValue)")
                return defaultValue
            }
            return valueX
        }

        set {
            set(newValue as AnyObject)
        }
    }
}
