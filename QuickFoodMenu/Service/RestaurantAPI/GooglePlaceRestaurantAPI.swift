//
//  GooglePlaceRestaurantAPI.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/15/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation
import GooglePlaces

let GOOGLE_PLACE_API_URL = "https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@"

class GooglePlaceRestaurantAPI: RestaurantAPIStrategy {

    func fetchRestaurantInfo(withPlaceID placeID: String) -> Restaurant {
        self.loadPhotosForPlace(placeID: placeID)
        return Restaurant(name: "", address: "", placeID: "", imageURL:nil)
    }

    func loadPhotosForPlace(placeID: String) {
        let requestString = String(format:GOOGLE_PLACE_API_URL,placeID,GOOGLE_PLACE_WEB_API_KEY)
        NETSERVICE .fetchNetworkData(reqestType: .GET, urlStr: requestString) { (data, error) in
            let json = try? JSONSerialization.jsonObject(with: data!,
                                                         options:.allowFragments) as! [String: Any]
            print("Json Object:", json)
        }

    }

//    func loadFirstPhotoForPlace(placeID: String) {
//        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
//            if let error = error {
//                // TODO: handle the error.
//                print("Error: \(error.localizedDescription)")
//            } else {
//                if let photoArray = photos?.results {
//                    for photo in photoArray {
//                        //                        self.loadImageForMetadata(photoMetadata: firstPhoto)
//                    }
//                }
//            }
//        }
//    }
}
