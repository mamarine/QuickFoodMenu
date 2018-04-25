//
//  RestaurantInfoResponseMapper.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/26/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

import Foundation

final class RestaurantInfoResponseMapper: ResponseMapper<Restaurant>, ResponseMapperProtocol {

    static func process(_ obj: AnyObject?) throws -> Restaurant {
        return try process(obj, parse: { json in
            let name = json["result"]?["name"] as? String
            let address = json["result"]?["formatted_address"] as? String
            let placeID = json["result"]?["place_id"] as? String
            var imageURLs = Array<NetworkImage>()
            if let photoArray = json["result"]?["photos"] as? Array<AnyObject>, photoArray.count > 0 {
                for i in 0..<photoArray.count {
                    if let refStr = photoArray[i]["photo_reference"] as? String,
                        let width = photoArray[i]["width"] as? Float,
                        let height = photoArray[i]["height"] as? Float {
                        if let urlStr = buildURL(photoRef: refStr) {
                            imageURLs.append(NetworkImage(url:urlStr, width: width, height: height))
                        }
                    }
                }
            }

            if let name = name, let address = address, let placeID = placeID {
                return Restaurant(name: name, address: address, placeID: placeID, imageURLs: imageURLs)
            }
            return nil
        })
    }

    private static func buildURL(photoRef:String) -> URL? {
        return URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" + photoRef + "&key=\(GOOGLE_PLACE_WEB_API_KEY)")
    }
}
