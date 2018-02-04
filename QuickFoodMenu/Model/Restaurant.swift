//
//  Restaurant.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/14/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

struct Restaurant {
    var name:String;
    var address:String;
    var placeID:String;
    var foods = Array<Food>()
    init(name:String, address:String,placeID:String) {
        self.name = name
        self.address = address
        self.placeID = placeID
    }
}
