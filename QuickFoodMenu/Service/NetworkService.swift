//
//  NetworkService.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/2/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation
import Alamofire

let NETSERVICE = NetworkService.sharedInstance

final class NetworkService: NSObject {
    // MARK: singleton init
    static let sharedInstance = NetworkService()

    private override init() {}

    override func copy() -> Any {
        return self
    }

    override func mutableCopy() -> Any {
        return self
    }

    // MARK: YELP
    let yelpHeaders: HTTPHeaders = [
        "Authorization": "Basic <yelp API token>",
        "Accept": "application/json"
    ]

    let yelpURL = "https://api.yelp.com/v3/businesses/search?term=delis&latitude=37.786882&longitude=-122.399972"

    func test() {
        Alamofire.request(yelpURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: yelpHeaders)
            .validate()
            .responseJSON { (response) in

            switch response.result.isSuccess {
            case true:
                print("suucess")
            case false:
                print("fail")
            }
        }

    }

}
