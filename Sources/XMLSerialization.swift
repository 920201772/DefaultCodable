//
//  XMLSerialization.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/3/5.
//  Copyright © 2021 ITC. All rights reserved.
//

import Foundation

public enum XMLSerialization {
    
    public static func dictionary(data: Data) throws -> [String: Any] {
        let xml = Parser(data: data)
        xml.delegate = xml
        
        xml.parse()
        if let error = xml.parserError {
            throw error
        }
        
        return xml.storage.topContainer
    }
    
}

// MARK: - Parser
private extension XMLSerialization {
    
    final class Parser: XMLParser, XMLParserDelegate {
        
        private(set) var storage = DecodingStorage<[String: Any]>()
        
        func parser(_ parser: Foundation.XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            storage.push(container: attributeDict)
        }
        
        func parser(_ parser: Foundation.XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if storage.count == 1 { return }
            
            let dict = storage.topContainer
            
            storage.popContainer()
            
            if let element = storage.topContainer[elementName] {
                if var array = element as? [Any] {
                    array.append(dict)
                    storage.topContainer[elementName] = array
                } else {
                    storage.topContainer[elementName] = [element, dict]
                }
            } else {
                storage.topContainer[elementName] = dict
            }
        }
        
    }
    
}
