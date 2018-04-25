//
//  NetworkImage.swift
//  QuickFoodMenu
//
//  Created by maojie on 4/25/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit

class NetworkImage: NSObject {
    var url:URL
    var width:Float
    var height:Float

    init(url:URL, width:Float, height:Float) {
        self.url = url
        self.width = width
        self.height = height
    }
}
