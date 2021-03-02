//
//  JSONKeyedDecodingContainer.swift
//  JSON
//
//  Created by 杨柳 on 2021/2/26.
//  Copyright © 2021 Kun. All rights reserved.
//

import Foundation

struct JSONKeyedDecodingContainer<T: JSON, Key: CodingKey> {
    
    private let decoder: _JSONDecoder<T>
    private let container: [String: Any]
    
    init(decoder: _JSONDecoder<T>, container: [String: Any]) {
        self.decoder = decoder
        self.container = container
    }
    
}

// MARK: - Private
private extension JSONKeyedDecodingContainer {
    
    func getValue<Value>(key: String) -> Value? {
        if let value = container[key] as? Value {
            return value
        }
        
        return decoder.getValueDefault(key: key) as? Value
    }
    
    func _decode<Value>(_ type: Value.Type, forKey key: Key) throws -> Value {
        let keyName = key.stringValue
        
        guard let value: Value = getValue(key: keyName) else {
            throw DecodingError.keyNotFound(key, .init(codingPath: decoder.codingPath, debugDescription: "No value associated with key: \(keyName)."))
        }
        
        return value
    }
    
    func _decodeNil<Value>(_ type: Value.Type, forKey key: Key) throws -> Value? {
        try decodeNil(forKey: key) ? nil : try? _decode(type, forKey: key)
    }
    
}

// MARK: - KeyedDecodingContainerProtocol
extension JSONKeyedDecodingContainer: KeyedDecodingContainerProtocol {
    
    typealias Key = Key
    
    var allKeys: [Key] { container.keys.compactMap { Key(stringValue: $0) } }
    var codingPath: [CodingKey] { decoder.codingPath }
    
    func contains(_ key: Key) -> Bool {
        let value: Any? = getValue(key: key.stringValue)
        
        return value != nil
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        let keyName = key.stringValue
        
        guard let value: Any = getValue(key: keyName) else {
            throw DecodingError.keyNotFound(key, .init(codingPath: decoder.codingPath, debugDescription: "No value associated with key: \(keyName)."))
        }
                
        return value is NSNull
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        try _decode(type, forKey: key)
    }
    
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        try _decode(type, forKey: key)
    }
    
    func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        let value: Any
        
        switch type {
        case is JSON.Type, is JSONDecodableDictionaryMarker.Type:
            value = try _decode([String: Any].self, forKey: key)
        
        case is JSONDecodableArrayMarker.Type:
            value = try _decode([Any].self, forKey: key)
            
        default:
            value = try _decode(Any.self, forKey: key)
        }
        
        return try decoder.unbox(value, as: type)
    }
    
    func decodeIfPresent(_ type: Bool.Type, forKey key: Key) throws -> Bool? {
        try? _decode(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: String.Type, forKey key: Key) throws -> String? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: Double.Type, forKey key: Key) throws -> Double? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: Float.Type, forKey key: Key) throws -> Float? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: Int.Type, forKey key: Key) throws -> Int? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: Int8.Type, forKey key: Key) throws -> Int8? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: Int16.Type, forKey key: Key) throws -> Int16? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: Int32.Type, forKey key: Key) throws -> Int32? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: Int64.Type, forKey key: Key) throws -> Int64? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: UInt.Type, forKey key: Key) throws -> UInt? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: UInt8.Type, forKey key: Key) throws -> UInt8? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: UInt16.Type, forKey key: Key) throws -> UInt16? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: UInt32.Type, forKey key: Key) throws -> UInt32? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent(_ type: UInt64.Type, forKey key: Key) throws -> UInt64? {
        try _decodeNil(type, forKey: key)
    }
    
    func decodeIfPresent<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T? {
        let value: Any?
        
        switch type {
        case is JSON.Type, is JSONDecodableDictionaryMarker.Type:
            value = try _decodeNil([String: Any].self, forKey: key)
        
        case is JSONDecodableArrayMarker.Type:
            value = try _decodeNil([Any].self, forKey: key)
            
        default:
            value = try _decodeNil(type, forKey: key)
        }
        
        if let value = value {
            return try decoder.unbox(value, as: type)
        } else {
            return nil
        }
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        let value = try _decode([String: Any].self, forKey: key)
        let container = JSONKeyedDecodingContainer<T, NestedKey>(decoder: decoder, container: value)
        
        return KeyedDecodingContainer(container)
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        let value = try _decode([Any].self, forKey: key)
        
        return JSONUnkeyedDecodingContainer(decoder: decoder, container: value)
    }
    
    func superDecoder() throws -> Decoder {
        decoder
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        decoder
    }
    
}
