//
//  NetworkConfiguration.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/23/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

public final class NetworkConfiguration {

    let baseURL: URL

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    public static var shared: NetworkConfiguration!
}
