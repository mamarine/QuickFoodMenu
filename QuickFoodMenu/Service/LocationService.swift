//
//  LocationService.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/9/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation
import GooglePlaces

let LOCATIONSERVICE = LocationService.sharedInstance

final class LocationService : NSObject {

    private var placesClient: GMSPlacesClient!
    private let locationManager = CLLocationManager()
    // MARK: singleton init
    static let sharedInstance = LocationService()

    private override init() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        placesClient = GMSPlacesClient.shared()
    }

    override func copy() -> Any {
        return self
    }

    override func mutableCopy() -> Any {
        return self
    }

    func getCurrentPlace() {
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }

            if let placeLikelihoodList = placeLikelihoodList {
                var itemCount = PLACES_LOAD_MAX_AMOUNT;
                for likelihood in placeLikelihoodList.likelihoods {
                    itemCount = itemCount - 1
                    if itemCount < 0 {
                        break
                    }

                    print("place.name:\(likelihood.place.name)")
                    let typeArray = likelihood.place.types
                    for typeStr in typeArray {
                        print("type:\(typeStr)")
                    }

//                    let test = GooglePlaceRestaurantAPI()
//                    test.fetchRestaurantInfo(withPlaceID: likelihood.place.placeID)
                    let operation = FetchRestaurantInfoOperation(placeID: likelihood.place.placeID)
//                    signUpOp.success = { item in
//                        print("User id is \(item.uniqueId)")
//                    }
//
//                    signUpOp.failure = { error in print(error.localizedDescription) }
                    NetworkQueue.shared.addOperation(operation)
                }
            }
        })
    }


}
