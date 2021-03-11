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
    
    static func decode(url: URL, options: CodableOptions = DefaultCodableOptions, userInfo: [AnyHashable: Any] = [:]) throws -> Self {
        let decoder = DefaultDecoder(options: [options, .xml], userInfo: userInfo)
        let dict = try XMLSerialization.dictionary(url: url)
        
        return try decoder.decode(self, dictionary: dict)
    }
    
    static func decode(path: String, options: CodableOptions = DefaultCodableOptions, userInfo: [AnyHashable: Any] = [:]) throws -> Self {
        try decode(url: .init(fileURLWithPath: path), options: options, userInfo: userInfo)
    }
     
}
