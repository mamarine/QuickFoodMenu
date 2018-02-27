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
}

