//
//  LaunchingViewController.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/2/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit


class LaunchingViewController: UIViewController {

    var restaurants:[Restaurant]?
    override func viewDidLoad() {
        super.viewDidLoad()

        RestaurantDataManager.shareInstance.fetchRestaurantDataForCurrentLocation { (restaurants, error) in
            guard error == nil else {
                return
            }
            self.restaurants = restaurants
            self.performSegue(withIdentifier: "RestaurantTableSegueVCID", sender: self)
        }

//        RestaurantDataManagerV1.shareInstance.fetchRestaurantData { error in
//            guard error == nil else {
//                return
//            }
//
//            self.performSegue(withIdentifier: "RestaurantTableSegueVCID", sender: self)
//        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RestaurantTableSegueVCID"  {
            if let navController = segue.destination as? UINavigationController {
                if let childVC = navController.topViewController as? RestaurantTableViewController {
                    guard let restaurants = self.restaurants else {
                        return
                    }
                    childVC.restaurants = restaurants

                }

            }

        }

    }
}

