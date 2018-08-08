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

    func getCurrentPlace(complete: ((GMSPlaceLikelihoodList?) -> Void)?) {
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }

            complete?(placeLikelihoodList)
        })
    }


}
