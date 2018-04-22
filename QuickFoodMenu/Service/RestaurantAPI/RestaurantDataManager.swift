//
//  RestaurantDataManager.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/15/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

class RestaurantDataManager: NSObject {
    private var restaurantInfos = Array<Restaurant>()

    static let shareInstance: RestaurantDataManager = {
        let instance = RestaurantDataManager()
        return instance
    } ()

    public func getRestaurants() -> Array<Restaurant> {
        return restaurantInfos
    }

    public func fetchRestaurantData(completeHandler handler: @escaping (NSError?) -> Void ) {
        LOCATIONSERVICE.getCurrentPlace { (list) in
            if let placeLikelihoodList = list {
                let group = DispatchGroup()
                var itemCount = PLACES_LOAD_MAX_AMOUNT;

                for likelihood in placeLikelihoodList.likelihoods {
                    itemCount = itemCount - 1
                    if itemCount < 0 {
                        break
                    }

                    let typeArray = likelihood.place.types
                    if !typeArray.contains("restaurant") && !typeArray.contains("food") && !typeArray.contains("cafe"){
                        continue
                    }
                    group.enter()
                    let operation = FetchRestaurantInfoOperation(placeID: likelihood.place.placeID)
                    operation.success = { [weak self] restaurant in
                        print("restaurant name is \(restaurant.name)")
                        self?.restaurantInfos.append(restaurant)
                        group.leave()
                    }

                    operation.failure = { error in
                        print("fail restaurant name is ")
                        group.leave()
                    }

                    NetworkQueue.shared.addOperation(operation)
                }
                group.notify(queue: .main) {
                    print("mjtest")
                    handler(nil)
                }
            }
        }
    }
}
