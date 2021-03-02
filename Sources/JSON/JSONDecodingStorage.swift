//
//  JSONDecodingStorage.swift
//  JSON
//
//  Created by 杨柳 on 2021/2/27.
//  Copyright © 2021 Kun. All rights reserved.
//

import Foundation

struct JSONDecodingStorage {
    
    private(set) var containers: [Any] = []
    
    var topContainer: Any { containers.last! }
    
    mutating func push(container: Any) {
        containers.append(container)
    }

    mutating func popContainer() {
        self.containers.removeLast()
    }
    
}
