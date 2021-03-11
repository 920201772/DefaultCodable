//
//  DefaultDecoder.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/2/26.
//  Copyright © 2021 Kun. All rights reserved.
//

import Foundation

public final class DefaultDecoder {
    
    public var userInfo: [AnyHashable: Any]
    
    public let options: CodableOptions
    
    fileprivate var defaultValues: [String: [String: Any]] = [:]
    fileprivate var realKeys: [String: [String: String]] = [:]
    
    init(options: CodableOptions = DefaultCodableOptions, userInfo: [AnyHashable: Any] = [:]) {
        self.options = options
        self.userInfo = userInfo
    }
    
}

// MARK: - Public
public extension DefaultDecoder {
    
    func decode<T: DefaultCodable>(_ type: T.Type, dictionary: [String: Any]) throws -> T {
        let decoder = _DefaultDecoder(decoder: self)
        return try decoder.unbox(dictionary, as: type)
    }
    
}

// MARK: - _DefaultDecoder
final class _DefaultDecoder {
    
    var topCodable: DefaultCodable.Type? {
        storage.topContainer.1 as? DefaultCodable.Type
    }
    
    let decoder: DefaultDecoder
    
    private var storage = DecodingStorage<(Any, Any.Type)>()
    
    init(decoder: DefaultDecoder) {
        self.decoder = decoder
    }
    
}

// MARK: - _DefaultDecoder Method
extension _DefaultDecoder {
    
    func unbox<T: Decodable>(_ value: Any, as type: T.Type) throws -> T {
        storage.push(container: (value, type))
        defer { storage.popContainer() }
        
        return try T.init(from: self)
    }
    
    func getRealKey(key: String) -> String {
        let type = String(reflecting: storage.topContainer.1)
        let realKey = decoder.realKeys[type] ?? {
            guard let codable = topCodable else {
                return [:]
            }
            
            let this = codable.keyMapping
            decoder.realKeys[type] = this
            
            return this
        }()
        
        if let key = realKey[key] {
            return key
        }
        
        if decoder.options.contains(.capitalized) {
            return key.prefixCapitalized
        }
        
        return key
    }
    
    func getValueDefault(key: String) -> Any? {
        let type = String(reflecting: storage.topContainer.1)
        let defaultValue = decoder.defaultValues[type] ?? {
            guard let codable = topCodable else {
                return [:]
            }
            
            let this = codable.defaultSerialization()
            decoder.defaultValues[type] = this
            
            return this
        }()
        
        return defaultValue[key]
    }
    
}

// MARK: - _DefaultDecoder Private
private extension _DefaultDecoder {
    
    func unbox<T>(_ type: T.Type) throws -> T {
        guard let value = storage.topContainer.0 as? T else {
            throw DecodingError.valueNotFound(type, .init(codingPath: codingPath, debugDescription: "Expected \(type) but found nil value instead."))
        }
        
        return value
    }
    
}

// MARK: - _DefaultDecoder Decoder
extension _DefaultDecoder: Decoder {
    
    var codingPath: [CodingKey] { [] }
    var userInfo: [CodingUserInfoKey: Any] { [:] }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        guard let topContainer = storage.topContainer.0 as? [String : Any] else {
            throw DecodingError.typeMismatch([String: Any].self, DecodingError.Context.init(codingPath: codingPath, debugDescription: "The given data was not valid Dictionary."))
        }

        let container = DefaultKeyedDecodingContainer<Key>(decoder: self, container: topContainer)
        
        return KeyedDecodingContainer(container)
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard let topContainer = storage.topContainer.0 as? [Any] else {
            throw DecodingError.typeMismatch([Any].self, DecodingError.Context.init(codingPath: codingPath, debugDescription: "The given data was not valid Array."))
        }

        return DefaultUnkeyedDecodingContainer(decoder: self, container: topContainer)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        self
    }
    
}

// MARK: _DefaultDecoder SingleValueDecodingContainer
extension _DefaultDecoder : SingleValueDecodingContainer {

    func decodeNil() -> Bool {
        storage.topContainer.0 is NSNull
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
        try unbox(storage.topContainer.0, as: type)
    }
    
}
