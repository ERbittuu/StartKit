//
//  Environment.swift
//  newproj
//
//  Created by CURRENTUSER on 28/1/19.
//  Copyright © 2019 ORGNAME. All rights reserved.
//

import Foundation

struct Environment {

    fileprivate enum PlistKey: String {
        case bundleId = "CFBundleIdentifier"
        case serverURL = "server_url"
        case info
    }

    static var bundleId: String {
        return Configuration.stringForKey(key: PlistKey.bundleId.rawValue)
    }

    static var info: String {
        return Configuration.stringForKey(key: PlistKey.info.rawValue)
    }

    static var serverURL: URL {
        if let url = URL(string: "https://" + Configuration.stringForKey(key: PlistKey.serverURL.rawValue)) {
            return url
        } else {
            fatalError("Something want wrong while creating url")
        }
    }

    static func printEnv() {
        print("----------------------------")
        print("App Info: \(info)")
        print("Bundle Identifire: \(bundleId)")
        print("Server URL: \(Environment.serverURL)")
        print("----------------------------\n")
    }
}

private struct Configuration {

    static func stringForKey(key: String) -> String {
        if let value = infoDict[key] as? String {
            return value
        } else {
            fatalError("\(key) not available")
        }
    }

    private static var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }
}
