//
//  GlobalConfig.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/14/18.
//  Copyright © 2018 maojie. All rights reserved.
//

let PLACES_LOAD_MAX_AMOUNT = 20

enum NetworkBuildConfiguration {
    case production
    case debug
}

class GlobalBuildConfig {
    static var networkAPIConfig = NetworkBuildConfiguration.debug
}
