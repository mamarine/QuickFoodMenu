//
//  LaunchingViewController.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/2/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit


class LaunchingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RestaurantDataManager.shareInstance.fetchRestaurantData { error in
            guard error == nil else {
                return
            }

            self.performSegue(withIdentifier: "RestaurantTableSegueVCID", sender: self)
        }
    }
}

