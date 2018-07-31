//
//  QFMObservable.swift
//  QuickFoodMenu
//
//  Created by maojie on 7/25/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit

class QFMObservable<T>: NSObject {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }

    init(value: T) {
        self.value = value
    }

    var valueChanged: ((T) -> Void)?
}
