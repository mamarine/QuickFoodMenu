//
//  Food.swift
//  QuickFoodMenu
//
//  Created by maojie on 1/14/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import Foundation

struct Food{
    var name:String
    var detail:String
    var imageURL:URL

    init(name: String, imageURL:URL, detail: String) {
        self.name = name
        self.imageURL = imageURL
        self.detail = detail
    }

}
