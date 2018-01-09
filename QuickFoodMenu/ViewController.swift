//
//  ViewController.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/2/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {

    var placesClient: GMSPlacesClient!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        placesClient = GMSPlacesClient.shared()
        self.getCurrentPlace()
    }

    func getCurrentPlace() {
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }

            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    print("place.name:\(place.name)")
                    var typeArray = place.types
                    for typeStr in typeArray {
                        print("type:\(typeStr)")
                    }
                    self.loadFirstPhotoForPlace(placeID: place.placeID)
                }
            }
        })
    }

    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let photoArray = photos?.results {
                    for firstPhoto in photoArray {
                        self.loadImageForMetadata(photoMetadata: firstPhoto)
                    }
                }
            }
        }
    }

    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        print("photo att:\(photoMetadata.attributions)")
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {


            }
        })
    }



}

