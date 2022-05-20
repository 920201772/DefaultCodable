//
//  DefaultUnkeyedDecodingContainer.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/2/27.
//  Copyright © 2021 Kun. All rights reserved.
//

import Foundation
import CoreGraphics

class DefaultUnkeyedDecodingContainer {
    
    private(set) var currentIndex = 0
    
    private let decoder: _DefaultDecoder
    private let container: [Any]
    
    init(decoder: _DefaultDecoder, container: [Any]) {
        self.decoder = decoder
        self.container = container
    }
    
}

// MARK: - Private
private extension DefaultUnkeyedDecodingContainer {
    
    func _decode<Value>(_ type: Value.Type) throws -> Value {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, .init(codingPath: codingPath, debugDescription: "Unkeyed container is at end."))
        }
        
        let value = container[currentIndex]
        currentIndex += 1
        
        if decoder.decoder.options.contains(.xml) {
            if let string = value as? String,
               let type = Value.self as? XMLRaw.Type,
               let value = type.init(rawString: string) as? Value {
                return value
            }
        }
        
        if let value = value as? Value {
            return value
        }
        
        return try _decode(type)
//        throw DecodingError.valueNotFound(type, .init(codingPath: codingPath, debugDescription: "Expected \(type) but found null instead."))
    }
    
    /// 枚举类型特化
    func _decode(_ type: _CodableEnumMarker.Type) throws -> Any {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, .init(codingPath: codingPath, debugDescription: "Unkeyed container is at end."))
        }
        
        let value = container[currentIndex]
        if decoder.decoder.options.contains(.xml) {
            if let string = value as? String,
               let rawType = type._rawType.self as? XMLRaw.Type,
               let value = rawType.init(rawString: string),
               type._isDecodable(rawValue: value) {
                currentIndex += 1
                return value
            }
        }
        
        currentIndex += 1
        return value
    }
    
}

// MARK: - KeyedDecodingContainerProtocol
extension DefaultUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    
    var codingPath: [CodingKey] { decoder.codingPath }
    var count: Int? { container.count }
    var isAtEnd: Bool { currentIndex >= count! }
    
    func decodeNil() throws -> Bool {
        guard !isAtEnd else {
            throw DecodingError.valueNotFound(Any?.self, .init(codingPath: codingPath, debugDescription: "Unkeyed container is at end."))
        }

        if container[currentIndex] is NSNull {
            currentIndex += 1
            
            return true
        } else {
            return false
        }
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        try _decode(type)
    }
    
    func decode(_ type: String.Type) throws -> String {
        try _decode(type)
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        try _decode(type)
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        try _decode(type)
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        try _decode(type)
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        try _decode(type)
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        try _decode(type)
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        try _decode(type)
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        try _decode(type)
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        try _decode(type)
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try _decode(type)
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try _decode(type)
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try _decode(type)
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try _decode(type)
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        let value: Any

        switch type {
        case is DefaultCodable.Type, is CodableDictionaryMarker.Type:
            value = try _decode([String: Any].self)

        case is CodableArrayMarker.Type:
            value = try _decode([Any].self)

        case is CGFloat.Type:
            value = try _decode(Double.self)

        case let enumType as _CodableEnumMarker.Type:
            value = try _decode(enumType)

        default:
            value = try _decode(type)
        }

        return try decoder.unbox(value, as: type)
    }
    
//    mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
//        let value: Any
//
//        switch type {
//        case is DefaultCodable.Type, is CodableDictionaryMarker.Type:
//            value = try _decode([String: Any].self)
//
//        case is CodableArrayMarker.Type:
//            value = try _decode([Any].self)
//
//        case is CGFloat.Type:
//            value = try _decode(Double.self)
//
//        case let enumType as _CodableEnumMarker.Type:
//            value = try _decode(enumType)
//
//        default:
//            value = try _decode(type)
//        }
//
//        return try decoder.unbox(value, as: type)
//    }
    
//    func decodeIfPresent(_ type: Int.Type) throws -> Int? {
//        <#code#>
//    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        let value = try _decode([String: Any].self)
        let container = DefaultKeyedDecodingContainer<NestedKey>(decoder: decoder, container: value)
        
        return KeyedDecodingContainer(container)
    }
    
    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        let value = try _decode([Any].self)
        
        return DefaultUnkeyedDecodingContainer(decoder: decoder, container: value)
    }
    
    func superDecoder() throws -> Decoder {
        decoder
    }
    
}
