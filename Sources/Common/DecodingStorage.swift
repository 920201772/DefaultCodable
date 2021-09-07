//
//  DecodingStorage.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/3/5.
//  Copyright © 2021 ITC. All rights reserved.
//

import Foundation

struct DecodingStorage<Element> {
    
    var topContainer: Element {
        get { containers[containers.endIndex - 1] }
        set { containers[containers.endIndex - 1] = newValue }
    }
    
    var count: Int { containers.count }
    var isEmpty: Bool { containers.isEmpty }
    
    private var containers: [Element] = []
    
    mutating func push(container: Element) {
        containers.append(container)
    }

    mutating func popContainer() {
        containers.removeLast()
    }
    
}
