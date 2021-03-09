//
//  DefaultUnkeyedDecodingContainer.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/2/27.
//  Copyright © 2021 Kun. All rights reserved.
//

import Foundation
import CoreGraphics

struct DefaultUnkeyedDecodingContainer {
    
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
    
    mutating func _decode<Value>(_ type: Value.Type) throws -> Value {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, .init(codingPath: codingPath, debugDescription: "Unkeyed container is at end."))
        }
        
        let value = container[currentIndex]
        if decoder.options.contains(.xml) {
            if let string = value as? String,
               let type = Value.self as? RawString.Type,
               let value = type.init(rawString: string) as? Value {
                currentIndex += 1
                
                return value
            }
        }
        
        if let value = value as? Value {
            currentIndex += 1
            
            return value
        }
        
        throw DecodingError.valueNotFound(type, .init(codingPath: codingPath, debugDescription: "Expected \(type) but found null instead."))
    }
    
}

// MARK: - KeyedDecodingContainerProtocol
extension DefaultUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    
    var codingPath: [CodingKey] { decoder.codingPath }
    var count: Int? { container.count }
    var isAtEnd: Bool { currentIndex >= count! }
    
    mutating func decodeNil() throws -> Bool {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(Any?.self, .init(codingPath: codingPath, debugDescription: "Unkeyed container is at end."))
        }

        if container[currentIndex] is NSNull {
            currentIndex += 1
            
            return true
        } else {
            return false
        }
    }
    
    mutating func decode(_ type: Bool.Type) throws -> Bool {
        try _decode(type)
    }
    
    mutating func decode(_ type: String.Type) throws -> String {
        try _decode(type)
    }
    
    mutating  func decode(_ type: Double.Type) throws -> Double {
        try _decode(type)
    }
    
    mutating  func decode(_ type: Float.Type) throws -> Float {
        try _decode(type)
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        try _decode(type)
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        try _decode(type)
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        try _decode(type)
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        try _decode(type)
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        try _decode(type)
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        try _decode(type)
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        try _decode(type)
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        try _decode(type)
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        try _decode(type)
    }
    
    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        try _decode(type)
    }
    
    mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
        let value: Any
        
        switch type {
        case is DefaultCodable.Type, is CodableDictionaryMarker.Type:
            value = try _decode([String: Any].self)
        
        case is CodableArrayMarker.Type:
            value = try _decode([Any].self)
            
        case is CGFloat.Type:
            value = try _decode(Double.self)
            
        default:
            value = try _decode(Any.self)
        }
        
        return try decoder.unbox(value, as: type)
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        let value = try _decode([String: Any].self)
        let container = DefaultKeyedDecodingContainer<NestedKey>(decoder: decoder, container: value)
        
        return KeyedDecodingContainer(container)
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        let value = try _decode([Any].self)
        
        return DefaultUnkeyedDecodingContainer(decoder: decoder, container: value)
    }
    
    func superDecoder() throws -> Decoder {
        decoder
    }
    
}
