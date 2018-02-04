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

enum NetworkServiceType: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case UPDATE = "UPDATE"
}

final class NetworkService: NSObject {
    static let sharedInstance = NetworkService()
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    var errorMessage = ""

    private override init() {}

    override func copy() -> Any {
        return self
    }

    override func mutableCopy() -> Any {
        return self
    }

    func fetchNetworkData(reqestType:NetworkServiceType, urlStr: String, completion: @escaping (Data?, String) -> ()) {
        dataTask?.cancel()
        if let urlComponents = URLComponents(string: urlStr) {
            guard let url = urlComponents.url else { return }
            var request = URLRequest(url: url)
            request.httpMethod = reqestType.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
                defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                    print(self.errorMessage)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    DispatchQueue.main.async {
                        completion(data, self.errorMessage)
                    }
                }
            }
            dataTask?.resume()
        }
    }


}
