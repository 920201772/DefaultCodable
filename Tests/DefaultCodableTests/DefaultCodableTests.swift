import XCTest
@testable import DefaultCodable

struct AAA: JSON {
    
    var age: [Int?] = [11]
    var name: String = ""
    var name1: String = "111"
//    var name2: [String: JSONMetadata] = [:]
//    var name3: JSONMetadata = 0
//
//    var b: BBB = BBB()
    
}

struct BBB: JSON {
    
    var a = "aaaaa"
    
}

struct CCC: JSON {
//    var b: [BBB?] = .init()
    var e: [EEE] = []
//    var c: [Int: BBB] = .init()
    var i = 100
    
}

enum EEE: String, JSONEnum {

    case a = "aa"
    case b = "bb"
    case c = "cc"
}

final class JSONTests: XCTestCase {
    
    func testExample() {
        do {
//            let a = try AAA.decode(text: #"{"age": [222, null], "age1": [{"a": "bbbb"}, {"a": "ccc"}], "name": "123", "b": {"a": "bbbb"}, "name2": {"S": true, "E": 2}, "name3": true}"#)
//            print(a)
            
            let c = try CCC.decode(text: #"{"b": [{"a": "ccc"}, {"a": "ddd"}], "e": ["bb", "cc", "bb", "aa"], "c": {"0": {"a": "ccc"}}, "i": 200}"#)
            
            print(c)
        } catch {
            print(error)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
}
