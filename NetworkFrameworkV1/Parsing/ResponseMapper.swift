//
//  ResponseMapper.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/26/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

protocol ResponseMapperProtocol {
    associatedtype Item
    static func process(_ obj: AnyObject?) throws -> Item
}

internal enum ResponseMapperError: Error {
    case invalid
    case missingAttribute
}

class ResponseMapper<T: ParsedItem> {

    static func process(_ obj: AnyObject?, parse: (_ json: [String: AnyObject]) -> T?) throws -> T {
        guard let json = obj as? [String: AnyObject] else { throw ResponseMapperError.invalid }
        if let item = parse(json) {
            return item
        } else {
            throw ResponseMapperError.missingAttribute
        }
    }
}
