//
//  RestaurantGoogleApiResponse.swift
//  QuickFoodMenu
//
//  Created by maojie on 5/30/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

extension Restaurant: Decodable {
    enum RootKeys: String,CodingKey {
        case result
    }

    enum RestaurantKeys: String, CodingKey {
        case name
        case address = "formatted_address"
        case placeID = "place_id"
        case photoArray = "photos"
    }

    enum NetworkImageKeys: String, CodingKey {
        case url = "photo_reference"
        case width = "width"
        case height = "height"
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        let restaurantContainer = try rootContainer.nestedContainer(keyedBy: RestaurantKeys.self, forKey: .result)
        let name = try restaurantContainer.decode(String.self, forKey:.name)
        let address = try restaurantContainer.decode(String.self, forKey:.address)
        let placeID = try restaurantContainer.decode(String.self, forKey:.placeID)

        var photosContainer = try restaurantContainer.nestedUnkeyedContainer(forKey: .photoArray)
        var photoArray = [NetworkImage]()
        while !photosContainer.isAtEnd {
            let photoContainer = try photosContainer.nestedContainer(keyedBy: NetworkImageKeys.self)
            let photoRef = try photoContainer.decode(String.self, forKey:.url)
            let width = try photoContainer.decode(Float.self, forKey:.width)
            let height = try photoContainer.decode(Float.self, forKey:.height)

            let url = Restaurant.buildImageURL(photoRef:photoRef)!
            let photoData = NetworkImage(url: url, width: width, height: height)
            photoArray.append(photoData)
        }
        self.init(name: name, address: address, placeID: placeID, imageURLs: photoArray)
    }

    private static func buildImageURL(photoRef:String) -> URL? {
        let router = Router<RestaurantGoogleApi>()
        return router.buildURL(from: RestaurantGoogleApi.restaurantPhoto(maxwidth: 400, photoreference: photoRef))
    }
}
