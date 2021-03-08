//
//  JSON.swift
//  JSON
//
//  Created by 杨柳 on 2021/2/25.
//  Copyright © 2021 Kun. All rights reserved.
//

import Foundation

public protocol JSON: DefaultCodable {}
public extension JSON {
    
    static func decode(data: Data) throws -> Self {
        let decoder = DefaultDecoder()
        guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw DecodingError.typeMismatch([String: Any].self, .init(codingPath: [], debugDescription: "The given data was not valid JSON."))
        }
        
        return try decoder.decode(self, from: dict)
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

