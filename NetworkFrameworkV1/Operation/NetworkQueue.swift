//
//  NetworkQueue.swift
//  QuickFoodMenu
//
//  Created by maojie on 2/26/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation
public class NetworkQueue {

    public static let shared = NetworkQueue()

    let queue = OperationQueue()

    public init() {}

    public func addOperation(_ op: Operation) {
        queue.addOperation(op)
    }
}
