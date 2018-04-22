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
            var urlStr = ""
            if let photoArray = json["result"]?["photos"] as? Array<AnyObject>, photoArray.count > 0 {
                let refStr = photoArray[0]["photo_reference"] as! String
                urlStr = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" + refStr + "&key=\(GOOGLE_PLACE_WEB_API_KEY)"
            }
            let imageURL = URL(string:urlStr)
            if let name = name, let address = address, let placeID = placeID {
                return Restaurant(name: name, address: address, placeID: placeID, imageURL:imageURL)
            }
            return nil
        })
    }
}

//https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU&key=YOUR_API_KEY
