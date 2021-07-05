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
        self.init(rawString)
    }
    
}

extension Float: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int8: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int16: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int32: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension Int64: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt8: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt16: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt32: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}

extension UInt64: XMLRaw {
    
    init?(rawString: String) {
        self.init(rawString)
    }
    
}
