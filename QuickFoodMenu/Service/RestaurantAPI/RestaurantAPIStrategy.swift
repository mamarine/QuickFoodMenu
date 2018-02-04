//
//  RestaurantAPIStrategy.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/15/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

protocol RestaurantAPIStrategy {
//    func fetchRestaurantInfo(withName name:String) -> Restaurant
    func fetchRestaurantInfo(withPlaceID placeID:String) -> Restaurant
}
