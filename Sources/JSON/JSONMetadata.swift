//
//  JSONMetadata.swift
//  JSON
//
//  Created by 杨柳 on 2019/8/2.
//  Copyright © 2019 com.kun. All rights reserved.
//

import Foundation

public struct JSONMetadata: Codable, CustomStringConvertible {
    
    
    var value: Any
    
    public var description: String { "\(value)" }
    
    init(_ value: Any) {
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            self.init(NSNull())
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else if let bool = try? container.decode(Bool.self) {
            self.init(bool)
        } else if let double = try? container.decode(Double.self) {
            self.init(double)
        } else if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let array = try? container.decode([JSONMetadata].self) {
            self.init(array.map { $0.value })
        } else if let dictionary = try? container.decode([String: JSONMetadata].self) {
            self.init(dictionary.mapValues { $0.value })
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Metadata value cannot be decoded")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch value {
        case is NSNull:
            try container.encodeNil()
            
        case let bool as Bool:
            try container.encode(bool)
            
        case let int as Int:
            try container.encode(int)
            
        case let double as Double:
            try container.encode(double)
            
        case let string as String:
            try container.encode(string)
            
        case let array as [Any]:
            try container.encode(array.map { JSONMetadata($0) })
            
        case let dictionary as [String: Any]:
            try container.encode(dictionary.mapValues { JSONMetadata($0) })
            
        default:
            let context = EncodingError.Context(codingPath: container.codingPath, debugDescription: "AnyCodable value cannot be encoded")
            throw EncodingError.invalidValue(value, context)
        }
    }
    
}

// MARK: - Literal
extension JSONMetadata: ExpressibleByNilLiteral {
    
    public init(nilLiteral: ()) {
        value = NSNull()
    }
}
extension JSONMetadata: ExpressibleByBooleanLiteral {
    
    public typealias BooleanLiteralType = Bool
    
    public init(booleanLiteral value: Bool) {
        self.value = value
    }
    
}
extension JSONMetadata: ExpressibleByIntegerLiteral {
    
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: Int) {
        self.value = value
    }
    
}
extension JSONMetadata: ExpressibleByFloatLiteral {
    
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: Double) {
        self.value = value
    }
    
}
extension JSONMetadata: ExpressibleByStringLiteral {
    
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.value = value
    }
    
}
extension JSONMetadata: ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = [JSONMetadata]
    
    public init(arrayLiteral elements: [JSONMetadata]...) {
        value = elements
    }
    
}
extension JSONMetadata: ExpressibleByDictionaryLiteral {
    
    public typealias Key = String
    public typealias Value = JSONMetadata
    
    public init(dictionaryLiteral elements: (String, JSONMetadata)...) {
        var dict: [String: JSONMetadata] = [:]
        elements.forEach { key, value in
            dict[key] = value
        }
        value = dict
    }
    
}
