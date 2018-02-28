//
//  Restaurant.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/14/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

struct Restaurant: ParsedItem {
    var name:String
    var address:String
    var placeID:String
    var foods = Array<Food>()
    var imageURL: URL?
    init(name:String, address:String,placeID:String,imageURL:URL?) {
        self.name = name
        self.address = address
        self.placeID = placeID
        self.imageURL = imageURL
    }
}
