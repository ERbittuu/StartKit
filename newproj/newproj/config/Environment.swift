//
//  Environment.swift
//  newproj
//
//  Created by Utsav Patel on 28/1/19.
//  Copyright © 2019 Solution Analysts. All rights reserved.
//

import Foundation

enum PlistKey {
    case bundleId
    case serverURL
    case timeoutInterval
    case connectionProtocol
    case info

    func value() -> String {
        switch self {
        case .bundleId:
            return kCFBundleIdentifierKey as String
        case .serverURL:
            return "server_url"
        case .timeoutInterval:
            return "timeout_interval"
        case .connectionProtocol:
            return "protocol"
        case .info:
            return "info"
        }
    }
}

struct Environment {

    fileprivate static func infoDict() -> [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }

    fileprivate static func configuration(_ key: PlistKey) -> String {
        switch key {
        case .serverURL:
            return infoDict()[PlistKey.serverURL.value()] as? String ?? ""
        case .timeoutInterval:
            return infoDict()[PlistKey.timeoutInterval.value()] as? String ?? ""
        case .connectionProtocol:
            return infoDict()[PlistKey.connectionProtocol.value()] as? String ?? ""
        case .info:
            return infoDict()[PlistKey.info.value()] as? String ?? ""
        case .bundleId:
            return infoDict()[PlistKey.bundleId.value()] as? String ?? ""
        }
    }

    public static func printEnv() {
        print("----------------------------")
        print("App Bundle Identifire: \(Environment.configuration(.bundleId))")
        print("App Environment: \(Environment.configuration(PlistKey.info))")
        print("App Info: \(Environment.configuration(PlistKey.info))")
        print("Server URL: \(Environment.serverURL()) ?? "Not defined"")
        print("----------------------------\n")
    }
}

extension Environment {
    public static func serverURL() -> URL? {
        let prot = Environment.configuration(.connectionProtocol)
        let url = Environment.configuration(.serverURL)
        return URL(string: prot + "://" + url)
    }
}
