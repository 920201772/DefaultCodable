//
//  XMLSerialization.swift
//  DefaultCodable
//
//  Created by 杨柳 on 2021/3/5.
//  Copyright © 2021 ITC. All rights reserved.
//

import Foundation

public final class XMLSerialization {
    
    public class func dictionary(url: URL) throws -> [String: Any] {
        guard let xml = _XMLParser(contentsOf: url) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "XML file not found."))
        }
        
        xml.delegate = xml
        
        xml.parse()
        if let error = xml.parserError {
            throw error
        }
        
        return xml.container as! [String: Any]
    }
    
}

// MARK: - _XMLDecode
private class _XMLParser: XMLParser {
     
    private(set) var container: NSMutableDictionary!
    
    private var storage = DecodingStorage<NSMutableDictionary>()
    
}

// MARK: - _XMLDecode XMLParserDelegate
extension _XMLParser: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        let attr = NSMutableDictionary(dictionary: attributeDict)
        
        if container == nil {
            container = attr
        } else if let element = storage.topContainer[elementName] {
            if let array = element as? NSMutableArray {
                array.add(attr)
            } else {
                storage.topContainer[elementName] = NSMutableArray(arrayLiteral: element, attr)
            }
        } else {
            storage.topContainer[elementName] = attr
        }
        
        storage.push(container: attr)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        storage.popContainer()
    }
    
}
