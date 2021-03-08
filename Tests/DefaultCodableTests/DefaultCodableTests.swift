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

final class JSONTests: XCTestCase {
    
    func testExample() {
        do {
            let a = try AAA.decode(text: #"{"age": [222, null], "age1": [{"a": "bbbb"}, {"a": "ccc"}], "name": "123", "b": {"a": "bbbb"}, "name2": {"S": true, "E": 2}, "name3": true}"#)
            print(a)
        } catch {
            print(error)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
}
