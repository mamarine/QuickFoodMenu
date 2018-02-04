//
//  ViewController.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/2/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        LOCATIONSERVICE.getCurrentPlace()

        


    }



//    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
//        print("photo att:\(photoMetadata.attributions)")
//        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
//            (photo, error) -> Void in
//            if let error = error {
//                // TODO: handle the error.
//                print("Error: \(error.localizedDescription)")
//            } else {
//
//
//            }
//        })
//    }



}

