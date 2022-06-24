//
//  XML.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/3/5.
//  Copyright © 2021 ITC. All rights reserved.
//

import Foundation

public protocol XML: DefaultCodable {}
public extension XML {
    
    static func decode(xml data: Data, options: CodableOptions = DefaultCodableOptions, userInfo: [AnyHashable: Any] = [:]) throws -> Self {
        let decoder = DefaultDecoder(options: [options, .xml], userInfo: userInfo)
        let dict = try XMLSerialization.dictionary(data: data)
        
        return try decoder.decode(self, dictionary: dict)
    }
    
    static func decode(xml text: String, options: CodableOptions = DefaultCodableOptions, userInfo: [AnyHashable: Any] = [:]) throws -> Self {
        guard let data = text.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Encoding utf-8 fail."))
        }
        
        return try decode(xml: data, options: options, userInfo: userInfo)
    }
    
    static func decode(xml url: URL, options: CodableOptions = DefaultCodableOptions, userInfo: [AnyHashable: Any] = [:]) throws -> Self {
        let data = try Data(contentsOf: url)
        return try decode(xml: data, options: options, userInfo: userInfo)
    }
    
    static func decode(xmlPath: String, options: CodableOptions = DefaultCodableOptions, userInfo: [AnyHashable: Any] = [:]) throws -> Self {
        try decode(xml: .init(fileURLWithPath: xmlPath), options: options, userInfo: userInfo)
    }
     
}
