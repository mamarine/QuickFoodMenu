//
//  NSError+Failure.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/27/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

extension NSError {
    class func cannotParseResponse() -> NSError {
        let info = [NSLocalizedDescriptionKey: "Can't parse response. Please report a bug."]
        return NSError(domain: String(describing: self), code: 0, userInfo: info)
    }
}
