//
//  DecodingStorage.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/3/5.
//  Copyright © 2021 ITC. All rights reserved.
//

import Foundation

struct DecodingStorage<Element> {
    
    private var containers: [Element] = []
    
    var topContainer: Element { containers.last! }
    
    mutating func push(container: Element) {
        containers.append(container)
    }

    mutating func popContainer() {
        containers.removeLast()
    }
    
}
