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
    var coverImage: NetworkImage
    var images: Array<NetworkImage>
    init(name:String, address:String, placeID:String, imageURLs:Array<NetworkImage>) {
        self.name = name
        self.address = address
        self.placeID = placeID
        self.coverImage = imageURLs.first ?? NetworkImage(url: URL(fileURLWithPath: "emptyDish"),width: 0,height: 0)
        self.images = imageURLs
    }
}
