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
            let imageURL = URL(string:"test")
            if let name = name, let address = address, let placeID = placeID {
                return Restaurant(name: name, address: address, placeID: placeID, imageURL:imageURL)
            }
            return nil
        })
    }
}
