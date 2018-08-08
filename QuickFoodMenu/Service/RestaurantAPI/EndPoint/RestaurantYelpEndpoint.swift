//
//  RestaurantYelpEndpoint.swift
//  QuickFoodMenu
//
//  Created by maojie on 8/7/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

public enum RestaurantYelpApi {
    case restaurantInfo(name:String)
    case restaurantPhotos(restaurantID:String)
}

extension RestaurantYelpApi: EndPointType {
    var buildConfigBaseURL: String {
        switch GlobalBuildConfig.networkAPIConfig {
        case .debug:
            return "https://api.yelp.com/v3"
//            return "https://api.yelp.com/v3/businesses/search?term=delis&latitude=37.786882&longitude=-122.399972"
        case .production:
            return "https://api.yelp.com/v3"
        }
    }

    var buildConfigAPIKey: String {
        switch GlobalBuildConfig.networkAPIConfig {
        case .debug:
            return YELP_API_KEY
        case .production:
            return YELP_API_KEY
        }
    }

    var baseURL: URL {
        guard let url = URL(string: buildConfigBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .restaurantInfo:
            return "/businesses/matches"
        case .restaurantPhotos(let restaurantID):
            return "/businesses/\(restaurantID)"
        }
    }

    var httpMethod: HTTPMethod {
        return .GET
    }

    var task: HTTPTask {
        switch self {
        case .restaurantInfo(let name):
            //name=Bancarella&city=San Francisco&address1=350 Powell St&state=ca&country=US
            return .requestParameters(bodyParameters: ["Content-Type":"application/json",
                                                       "Authorization":"Bearer " + buildConfigAPIKey],
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["name":name,
                                                      "city":"",
                                                      "address1":"",
                                                      "state":"",
                                                      "country":""])
        case .restaurantPhotos:
            return .requestParameters(bodyParameters: ["Content-Type":"application/json",
                                                       "Authorization":"Bearer " + buildConfigAPIKey],
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
