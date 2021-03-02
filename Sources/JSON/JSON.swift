//
//  JSON.swift
//  JSON
//
//  Created by 杨柳 on 2021/2/25.
//  Copyright © 2021 Kun. All rights reserved.
//

import Foundation

public protocol JSON: Codable {
    
    init()
    
}

// MARK: - Public
public extension JSON {
    
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(self, from: data)
    }
    
    static func decode(text: String) throws -> Self {
        guard let data = text.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Encoding utf-8 fail."))
        }
        
        return try decode(data: data)
    }
    
}

// MARK: - Method
extension JSON {
    
    static func defaultEncodeJSON() -> [String: Any] {
        (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self.init()))) as? [String: Any] ?? [:]
    }
    
}

