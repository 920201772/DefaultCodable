//
//  XMLRaw.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/3/5.
//  Copyright © 2021 ITC. All rights reserved.
//

import Foundation

protocol XMLRaw {
    
    init?(rawString: String)
    
}

extension Bool: XMLRaw {
    
    init?(rawString: String) {
        switch rawString {
        case "True": self.init(true)
        case "False": self.init(false)
        default: return nil
        }
    }
    
}

extension String: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Double: XMLRaw {

    init?(rawString: String) {
        self = 0.0
        if !Scanner(string: rawString).scanDouble(&self) {
            return nil
        }
    }

}

extension Float: XMLRaw {

    init?(rawString: String) {
        self = 0.0
        if !Scanner(string: rawString).scanFloat(&self) {
            return nil
        }
    }

}

extension FixedWidthInteger {

    init?(rawString: String) {
        if Self.isSigned {
            var value: Int64 = 0
            if Scanner(string: rawString).scanInt64(&value) {
                value.limit(Int64(Self.min)...Int64(Self.max))
                self = .init(value)
            } else {
                return nil
            }
        } else {
            var value: UInt64 = 0
            if Scanner(string: rawString).scanUnsignedLongLong(&value) {
                value.limit(UInt64(Self.min)...UInt64(Self.max))
                self = .init(value)
            } else {
                return nil
            }
        }
    }

}

extension Int: XMLRaw {}
extension Int8: XMLRaw {}
extension Int16: XMLRaw {}
extension Int32: XMLRaw {}
extension Int64: XMLRaw {}
extension UInt: XMLRaw {}
extension UInt8: XMLRaw {}
extension UInt16: XMLRaw {}
extension UInt32: XMLRaw {}
extension UInt64: XMLRaw {}
