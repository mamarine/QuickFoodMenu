//
//  NetworkService.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/23/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

public let DidPerformUnauthorizedOperation = "DidPerformUnauthorizedOperation"

class NetworkService {
    private let action = NetworkAction()
    private let conf: NetworkConfiguration

    init(_ conf: NetworkConfiguration) {
        self.conf = conf
    }

    func request(_ request: NetworkRequest,
                 success: ((AnyObject?) -> Void)? = nil,
                 failure: ((NSError) -> Void)? = nil) {

        let url = conf.baseURL.appendingPathComponent(request.endpoint)

        let headers = request.headers
        // Set authentication token if available.
        //        headers?["X-Api-Auth-Token"] = BackendAuth.shared.token

        action.makeRequest(for: url, method: request.method, query: request.query, params: request.parameters, headers: headers, success: { data in
            var json: AnyObject? = nil
            if let data = data {
                json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as AnyObject
            }
            success?(json)

        }, failure: { data, error, statusCode in
            if statusCode == 401 {
                // Operation not authorized
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: DidPerformUnauthorizedOperation), object: nil)
                return
            }

            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as AnyObject
                let info = [
                    NSLocalizedDescriptionKey: json?["error"] as? String ?? "",
                    NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                ]
                let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
                failure?(error)
            } else {
                failure?(error ?? NSError(domain: "BackendService", code: 0, userInfo: nil))

            }
        })
    }

    func cancel() {
        action.cancel()
    }

}
