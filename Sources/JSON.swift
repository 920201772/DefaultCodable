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
    
    static func decode(data: Data, options: CodableOptions = DefaultCodableOptions, userInfo: [AnyHashable: Any] = [:]) throws -> Self {
        let decoder = DefaultDecoder(options: options, userInfo: userInfo)
        guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw DecodingError.typeMismatch([String: Any].self, .init(codingPath: [], debugDescription: "The given data was not valid JSON."))
        }
        
        return try decoder.decode(self, dictionary: dict)
    }
    
    static func decode(text: String, options: CodableOptions = DefaultCodableOptions, userInfo: [AnyHashable: Any] = [:]) throws -> Self {
        guard let data = text.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Encoding utf-8 fail."))
        }
        
        return try decode(data: data, options: options, userInfo: userInfo)
    }
    
    func encodeJSONData() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    func encodeJSONString() throws -> String {
        let data = try encodeJSONData()
        if let text = String(data: data, encoding: .utf8) {
            return text
        }
        
        throw EncodingError.invalidValue(data, .init(codingPath: [], debugDescription: "Encoding utf-8 fail."))
    }
    
    func encodeJSON() throws -> [String: Any] {
        let data = try encodeJSONData()
        if let dic = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return dic
        }
        
        throw EncodingError.invalidValue(data, .init(codingPath: [], debugDescription: "Encoding dictionary fail."))
    }
    
}
