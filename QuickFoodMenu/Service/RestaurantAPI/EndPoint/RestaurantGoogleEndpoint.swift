//
//  RestaurantGoogleEndpoint.swift
//  QuickFoodMenu
//
//  Created by maojie on 5/29/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

public enum RestaurantGoogleApi {
    case restaurantInfo(placeID:String)
    case restaurantPhoto(maxwidth:Int,photoreference:String)
}

extension RestaurantGoogleApi: EndPointType {
    var buildConfigBaseURL: String {
        switch GlobalBuildConfig.networkAPIConfig {
        case .debug:
            return "https://maps.googleapis.com/maps/api/place"
        case .production:
            return "https://maps.googleapis.com/maps/api/place"
        }
    }

    var buildConfigAPIKey: String {
        switch GlobalBuildConfig.networkAPIConfig {
        case .debug:
            return GOOGLE_PLACE_WEB_API_KEY
        case .production:
            return GOOGLE_PLACE_WEB_API_KEY
        }
    }

    var baseURL: URL {
        guard let url = URL(string: buildConfigBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .restaurantInfo:
            return "/details/json"
        case .restaurantPhoto:
            return "/photo"
        }
    }

    var httpMethod: HTTPMethod {
        return .GET
    }

    var task: HTTPTask {
        switch self {
        case .restaurantInfo(let placeID):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["placeid":placeID,
                                                      "key":buildConfigAPIKey])
        case .restaurantPhoto(let maxwidth, let photoreference):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["maxwidth":maxwidth,
                                                      "photoreference":photoreference,
                                                      "key":buildConfigAPIKey])
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
