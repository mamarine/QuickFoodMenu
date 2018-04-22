//
//  FetchRestaurantInfoOperation.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/26/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation
let GOOGLE_PLACE_WEBAPI_URL = "https://maps.googleapis.com/maps/api/place"
class FetchRestaurantInfoOperation: NetworkOperation {
    private let request: FetchRestaurantInfoRequest

    public var success: ((Restaurant) -> Void)?
    public var failure: ((NSError) -> Void)?

    public init(placeID: String) {
        request = FetchRestaurantInfoRequest(placeID: placeID)
        super.init(withURL: GOOGLE_PLACE_WEBAPI_URL)
    }

    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }

    private func handleSuccess(_ response: AnyObject?) {
        do {
            let item = try RestaurantInfoResponseMapper.process(response)
            self.success?(item)
            self.finish()
        } catch {
            handleFailure(NSError.cannotParseResponse())
        }
    }

    private func handleFailure(_ error: NSError) {
        self.failure?(error)
        self.finish()
    }
}