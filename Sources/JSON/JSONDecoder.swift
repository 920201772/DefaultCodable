//
//  JSONDecoder.swift
//  JSONDecoder
//
//  Created by 杨柳 on 2021/2/26.
//  Copyright © 2021 Kun. All rights reserved.
//

import Foundation

class JSONDecoder {
    
    fileprivate var defaultValues: [String: [String: Any]] = [:]
    
}

protocol JSONDecodableArrayMarker {}
extension Array: JSONDecodableArrayMarker where Element: Any {}
protocol JSONDecodableDictionaryMarker {}
extension Dictionary: JSONDecodableDictionaryMarker where Key == String, Value: Any {}
protocol JSONDecodableOptionalMarker {}
extension Optional: JSONDecodableOptionalMarker where Wrapped: Any {}

// MARK: - Method
extension JSONDecoder {
    
    func decode<T: JSON>(_ type: T.Type, from data: Data) throws -> T {
        guard let value = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw DecodingError.typeMismatch([String: Any].self, .init(codingPath: [], debugDescription: "The given data was not valid JSON."))
        }
        
        let decoder = _JSONDecoder<T>(decoder: self)
        
        return try decoder.unbox(value, as: type)
    }
    
}

// MARK: - _JSONDecoder
class _JSONDecoder<T: JSON> {
    
    private var storage = JSONDecodingStorage()
    private lazy var typeName = "\(T.self)"
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
}

// MARK: - _JSONDecoder Method
extension _JSONDecoder {
    
    func unbox<T: Decodable>(_ value: Any, as type: T.Type) throws -> T {
        storage.push(container: value)
        defer { storage.popContainer() }
        
        return try T.init(from: self)
    }
    
    func getValueDefault(key: String) -> Any? {
        let defaultValue = decoder.defaultValues[typeName] ?? {
            let this = T.defaultEncodeJSON()
            decoder.defaultValues[typeName] = this
            
            return this
        }()
        
        return defaultValue[key]
    }
    
}

// MARK: - _JSONDecoder Private
private extension _JSONDecoder {
    
    func unbox<T>(_ type: T.Type) throws -> T {
        guard let value = storage.topContainer as? T else {
            throw DecodingError.valueNotFound(type, .init(codingPath: codingPath, debugDescription: "Expected \(type) but found nil value instead."))
        }
        
        return value
    }
    
}

// MARK: - _JSONDecoder Decoder
extension _JSONDecoder: Decoder {
    
    var codingPath: [CodingKey] { [] }
    var userInfo: [CodingUserInfoKey: Any] { [:] }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        guard let topContainer = storage.topContainer as? [String : Any] else {
            throw DecodingError.typeMismatch([String: Any].self, DecodingError.Context.init(codingPath: codingPath, debugDescription: "The given data was not valid Dictionary."))
        }

        let container = JSONKeyedDecodingContainer<T, Key>(decoder: self, container: topContainer)
        
        return KeyedDecodingContainer(container)
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard let topContainer = storage.topContainer as? [Any] else {
            throw DecodingError.typeMismatch([Any].self, DecodingError.Context.init(codingPath: codingPath, debugDescription: "The given data was not valid Array."))
        }

        return JSONUnkeyedDecodingContainer(decoder: self, container: topContainer)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        self
    }
    
}

// MARK: _JSONDecoder SingleValueDecodingContainer
extension _JSONDecoder : SingleValueDecodingContainer {

    func decodeNil() -> Bool {
        storage.topContainer is NSNull
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        try unbox(type)
    }

    func decode(_ type: Int.Type) throws -> Int {
        try unbox(type)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        try unbox(type)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        try unbox(type)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        try unbox(type)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        try unbox(type)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        try unbox(type)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try unbox(type)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try unbox(type)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try unbox(type)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try unbox(type)
    }

    func decode(_ type: Float.Type) throws -> Float {
        try unbox(type)
    }

    func decode(_ type: Double.Type) throws -> Double {
        try unbox(type)
    }

    func decode(_ type: String.Type) throws -> String {
        try unbox(type)
    }

    func decode<T : Decodable>(_ type: T.Type) throws -> T {
        try unbox(storage.topContainer, as: type)
    }
    
}
