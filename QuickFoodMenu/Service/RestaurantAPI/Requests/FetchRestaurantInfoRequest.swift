//
//  FetchRestaurantInfoRequest.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/26/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

class FetchRestaurantInfoRequest : NetworkRequest {
    private let placeID: String

    init(placeID: String) {
        self.placeID = placeID
    }

    var endpoint: String {
        return "/details/json"
    }

    var method: NetworkAction.Method {
        return .get
    }

    var query: NetworkAction.QueryType {
        return .path
    }

    var parameters: [String : Any]? {
        return ["placeid":self.placeID, "key":GOOGLE_PLACE_WEB_API_KEY]
    }

    var headers: [String : String]? {
        return defaultJSONHeaders()
    }
}
