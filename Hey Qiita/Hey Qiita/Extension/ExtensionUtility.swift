//
//  ExtensionUtility.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/12.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import Foundation

/// ちょっとしたExtensionはここに（UIKitは含まない）

// MARK: - Optional
extension Optional {
    var isNotNil: Bool {
        switch self {
        case .some: return true
        case .none: return false
        }
    }
}

extension Optional where Wrapped: StringProtocol {
    var isEmpty: Bool {
        switch self {
        case .some(let string): return string.isEmpty
        case .none: return true
        }
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Optional where Wrapped: Collection {
    var isEmpty: Bool {
        switch self {
        case .some(let sequence): return sequence.isEmpty
        case .none: return true
        }
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

// MARK: - String
extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

// MARK: - Array
extension Array {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

// MARK: - URL
extension URL {
    // MARK: - QueryParameters
    var queryParameters: [String: String] {
        var params = [String: String]()
        guard let comps = URLComponents(string: absoluteString),
            let queries = comps.queryItems else { return params }
        queries.forEach {
            params[$0.name] = $0.value
        }
        return params
    }
}
