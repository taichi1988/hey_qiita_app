//
//  KeychainUtil.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/30.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import KeychainAccess

// MARK: - KeychainAccess Utility
final class KeychainUtil {
    enum Key: String {
        case accessToken = "keychain_access_token"
    }
    
    private static let keychain = Keychain().synchronizable(true)
    
    // MARK: -
    static func remove(forKey key: Key) {
        do {
            try keychain.remove(key.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - AccessToken
    static var accessToken: String {
        get {
            do { return try keychain.get(Key.accessToken.rawValue) ?? "" }
            catch { return "" }
        }
        set {
            do { try keychain.set(newValue, key: Key.accessToken.rawValue) }
            catch let error { print(error.localizedDescription) }
        }
    }
}
