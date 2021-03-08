//
//  RawString.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/3/5.
//  Copyright © 2021 ITC. All rights reserved.
//

import Foundation

protocol RawString {
    
    init?(rawString: String)
    
}

extension Bool: RawString {
    
    init?(rawString: String) {
        switch rawString {
        case "True": self.init(true)
        case "False": self.init(false)
        default: return nil
        }
        
        
    }
    
}

extension String: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Double: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Float: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int8: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int16: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int32: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int64: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt8: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt16: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt32: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt64: RawString {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}
