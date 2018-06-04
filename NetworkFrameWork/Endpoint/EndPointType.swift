//
//  EndPointType.swift
//  QuickFoodMenu
//
//  Created by maojie on 5/29/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
