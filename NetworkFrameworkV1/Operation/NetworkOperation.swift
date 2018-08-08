//
//  ServiceOperation.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/25/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

class NetworkOperation: AsyncOperation {
    let service: NetworkService

    public override init() {
        self.service = NetworkService(NetworkConfiguration.shared)
        super.init()
    }

    public init(withURL URLStr: String) {
        let url = URL(string: URLStr)!
        let config = NetworkConfiguration(baseURL: url)
        self.service = NetworkService(config)
        super.init()
    }

    public override func cancel() {
        service.cancel()
        super.cancel()
    }
}
