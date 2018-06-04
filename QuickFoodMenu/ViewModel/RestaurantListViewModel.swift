//
//  RestaurantListViewModel.swift
//  QuickFoodMenu
//
//  Created by maojie on 6/3/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

struct RestaurantListCellViewModel {
    let coverImage:NetworkImage
    let images:[NetworkImage]
}

class RestaurantListViewModel {
    private var restaurants = [Restaurant]()
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?

    private var cellViewModels = [RestaurantListCellViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadTableViewClosure?()
            }

        }
    }

    var isLoading = false {
        didSet {
            DispatchQueue.main.async {
                self.updateLoadingStatus?()
            }
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }

    func getCellViewModel(at indexPath:IndexPath) -> RestaurantListCellViewModel {
        return cellViewModels[indexPath.row]
    }

    func fetchRestaurantData() {
        self.isLoading = true
        RestaurantDataManager.shareInstance.fetchRestaurantDataForCurrentLocation { [weak self] (restaurants, error) in
            self?.isLoading = false
            guard error == nil else {
                return
            }
            self?.processFetchedRestaurant(restaurants: restaurants)

        }
    }

    private func processFetchedRestaurant(restaurants:[Restaurant]) {
        var cellVMs = [RestaurantListCellViewModel]()
        for restaurant in restaurants {
            let vm = RestaurantListCellViewModel(coverImage:restaurant.coverImage, images: restaurant.images)
            cellVMs.append(vm)
        }
        self.restaurants = restaurants
        self.cellViewModels = cellVMs;
    }
}
