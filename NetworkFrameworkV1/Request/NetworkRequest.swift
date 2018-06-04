//
//  NetworkRequest.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/4/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    var endpoint: String { get }
    var method: NetworkAction.Method { get }
    var query: NetworkAction.QueryType { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension NetworkRequest {
    func defaultJSONHeaders() -> [String: String] {
        return ["Content-Type": "application/json"]
    }
}
