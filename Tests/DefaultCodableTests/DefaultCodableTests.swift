import XCTest
import DefaultCodable

struct AAA: JSON {
    
//    var age: [String] = []
//    var name: String = ""
    var name1: BBB? = BBB()
    
//    init(from decoder: Decoder) throws {
//
//    }
    init() {
        
    }
//    func encode(to encoder: Encoder) throws {
//
//    }
//    var name2: [String: JSONMetadata] = [:]
//    var name3: JSONMetadata = 0
//
//    var b: BBB = BBB()
    
}

struct BBB: JSON {
    
    var a: String? = "aaaaa"
    
}

enum EEE: String, JSONEnum {

    case a = "aa"
    case b = "bb"
    case c = "cc"
}

final class JSONTests: XCTestCase {
    
    func testExample() {
//        HappyCodable
//        https://github.com/apple/swift/blob/88b093e9d77d6201935a2c2fb13f27d961836777/stdlib/public/Darwin/Foundation/JSONEncoder.swift
        do {
            let a = try AAA.decode(text: """
            {
                "age": ["222"],
                "age1": [
                    {"a": "bbbb"}, {"a": "ccc"}
                ],
                "name": "123",
                "b": {
                    "a": "bbbb"
                },
                "name2": {
                    "S": true,
                    "E": 2
                },
                "name3": true,
                "name1": 123
            }
            """)
            print(a)
        } catch {
            print(error)
        }

        let decoder = JSONDecoder()
        decoder.decode(<#T##T#>, from: <#T##Foundation.Data#>)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
}
