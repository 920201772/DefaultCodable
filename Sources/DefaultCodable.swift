//
//  DefaultCodable.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/3/5.
//  Copyright © 2021 ITC. All rights reserved.
//

import Foundation

/// 默认选项
public var DefaultCodableOptions: CodableOptions = []

public protocol DefaultCodable: Codable {
    
    static var keyMapping: [String: String] { get }
    
    static func decode<T>(value: T, key: CodingKey, decoder: DefaultDecoder) -> T
    
    init()
    
}

public extension DefaultCodable {
    
    static var keyMapping: [String: String] { [:] }
    
    static func decode<T>(value: T, key: CodingKey, decoder: DefaultDecoder) -> T {
        value
    }
    
}

// MARK: - Public

public protocol _CodableEnumMarker {
    
    static var _rawType: Any.Type { get }
    
    static func _isDecodable(rawValue: Any) -> Bool
    
}

public protocol DefaultEnumCodable: Codable, _CodableEnumMarker, RawRepresentable where RawValue: Decodable {}
public typealias JSONEnum = DefaultEnumCodable
public typealias XMLEnum = DefaultEnumCodable

public struct CodableOptions: OptionSet {

    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    /// XML 解析
    static let xml = Self(rawValue: 1 << 0)
    
    /// key 首字母大写
    public static let capitalized = Self(rawValue: 1 << 0)
    
}

// MARK: - Method
protocol CodableArrayMarker {}
extension Array: CodableArrayMarker where Element: Any {}
protocol CodableDictionaryMarker {}
extension Dictionary: CodableDictionaryMarker where Key == String, Value: Any {}
protocol CodableOptionalMarker {}
extension Optional: CodableOptionalMarker where Wrapped: Any {}

extension DefaultCodable {
    
    static func defaultSerialization() -> [String: Any] {
        (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self.init()))) as? [String: Any] ?? [:]
    }
    
}

extension DefaultEnumCodable {
    
    static var _rawType: Any.Type { RawValue.self }
    
    static func _isDecodable(rawValue: Any) -> Bool {
        if let rawValue = rawValue as? RawValue {
            return Self.init(rawValue: rawValue) != nil
        }
        
        return false
    }
    
}
