//
//  RestaurantDataManager.swift
//  QuickFoodMenu
//
//  Created by maojie on 6/1/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

typealias RestaurantInternalApiCompletion = (_ restaurant:Restaurant?, _ error:String?) -> ()
typealias RestaurantApiCompletion = (_ restaurants:[Restaurant], _ error:String?) -> ()

public class RestaurantDataManager {
    let router = Router<RestaurantGoogleApi>()
    static let shareInstance: RestaurantDataManager = {
        return RestaurantDataManager()
    } ()

    private init() {}

    func fetchRestaurantDataForCurrentLocation(completion:@escaping RestaurantApiCompletion) {
        LOCATIONSERVICE.getCurrentPlace { (list) in
            guard let placeLikelihoodList = list else {
                return
            }
            var restaurantInfos = Array<Restaurant>()
            let group = DispatchGroup()
            var itemCount = PLACES_LOAD_MAX_AMOUNT

            for likelihood in placeLikelihoodList.likelihoods {
                itemCount -= 1
                if itemCount < 0 {
                    break
                }

                let typeArray = likelihood.place.types
                if !typeArray.contains("restaurant") && !typeArray.contains("food") && !typeArray.contains("cafe"){
                    continue
                }
                group.enter()
                self.fetchRestaurantInfo(placeID: likelihood.place.placeID, completion: { (restaurant, error) in
                    if let restaurant = restaurant {
                        restaurantInfos.append(restaurant)
                    }
                    group.leave()
                })
            }
            group.notify(queue: .main) {
                completion(restaurantInfos,nil)
            }
        }
    }

    private func fetchRestaurantInfo(placeID:String, completion: @escaping RestaurantInternalApiCompletion) {
        router.request(.restaurantInfo(placeID: placeID)) { (data, response, error) in
            guard error == nil else {
                return
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Restaurant.self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }

        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
