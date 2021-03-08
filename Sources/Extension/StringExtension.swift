//
//  StringExtension.swift
//  Kun
//
//  Created by 杨柳 on 2018/9/25.
//  Copyright © 2018年 com.kun. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    
    /// 字符串是否为空
    var isEmpty: Bool {
        switch self {
        case .none:
            return true
            
        case .some(let string):
            return string.isEmpty
        }
    }
    
}

extension String {
    
    /// 字符串为空返回占位符
    func isEmpty(_ placeholder: String) -> String {
        return isEmpty ? placeholder : self
    }
    
    /// 字符串截取
    subscript(_ index: Int) -> String {
        get { self[index...index] }
        set { self[index...index] = newValue }
    }
    /// 字符串截取(开区间,[0...])
    subscript(_ range: PartialRangeFrom<Int>) -> String {
        get {
            let lower = index(startIndex, offsetBy: range.lowerBound)
            return String(self[lower..<endIndex])
        }
        set {
            let lower = index(startIndex, offsetBy: range.lowerBound)
            replaceSubrange(lower..., with: newValue)
        }
    }
    /// 字符串截取(开区间,[...2])
    subscript(_ range: PartialRangeThrough<Int>) -> String {
        get {
            let upper = index(startIndex, offsetBy: range.upperBound)
            return String(self[startIndex...upper])
        }
        set {
            let upper = index(startIndex, offsetBy: range.upperBound)
            replaceSubrange(...upper, with: newValue)
        }
    }
    /// 字符串截取(开区间,[..<2])
    subscript(_ range: PartialRangeUpTo<Int>) -> String {
        get {
            let upper = index(startIndex, offsetBy: range.upperBound)
            return String(self[startIndex..<upper])
        }
        set {
            let upper = index(startIndex, offsetBy: range.upperBound)
            replaceSubrange(startIndex..<upper, with: newValue)
        }
        
    }
    /// 字符串截取(闭区间,[0...2])
    subscript(_ range: ClosedRange<Int>) -> String {
        get {
            let lower = index(startIndex, offsetBy: range.lowerBound)
            let upper = index(startIndex, offsetBy: range.upperBound)
            
            return String(self[lower...upper])
        }
        set {
            let lower = index(startIndex, offsetBy: range.lowerBound)
            let upper = index(startIndex, offsetBy: range.upperBound)
            
            replaceSubrange(lower...upper, with: newValue)
        }
    }
    /// 字符串截取(闭区间,[0..<2])
    subscript(_ range: Range<Int>) -> String {
        get {
            let lower = index(startIndex, offsetBy: range.lowerBound)
            let upper = index(startIndex, offsetBy: range.upperBound)
            
            return String(self[lower..<upper])
        }
        set {
            let lower = index(startIndex, offsetBy: range.lowerBound)
            let upper = index(startIndex, offsetBy: range.upperBound)
            
            replaceSubrange(lower..<upper, with: newValue)
        }
    }
    
    /// 返回开始到从末尾减去指定数量的字符串
    ///
    ///     let string = "123456"
    ///     print(numbers.prefix(lastTo: 3)
    ///     // Prints "123"
    ///
    /// - Parameter number: 指定数量
    func prefix(lastTo number: Int) -> String {
        let upper = index(startIndex, offsetBy: count - number)
        
        return String(self[startIndex..<upper])
    }
    
    /// 获取URL参数
    func getURLParameters() -> [String: String] {
        let last = components(separatedBy: "?").last
        let parameters = last?.components(separatedBy: "&")
        
        var dict: [String: String] = [:]
        parameters?.forEach {
            let keyValue = $0.components(separatedBy: "=")
            if keyValue.count == 2 {
                dict[keyValue[0]] = keyValue[1]
            }
        }
        
        return dict
    }
    
}
