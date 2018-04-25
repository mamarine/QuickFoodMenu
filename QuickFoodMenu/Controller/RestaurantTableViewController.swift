//
//  RestaurantTableViewController.swift
//  QuickFoodMenu
//
//  Created by maojie on 4/20/18.
//  Copyright © 2018 maojie. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantTableViewController: UITableViewController {
    var restaurants = RestaurantDataManager.shareInstance.getRestaurants()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCellReuseID", for: indexPath)

        if let cell = cell  as? RestaurantTableViewCell {
            cell.restaurantImageView.image = nil
            cell.restaurantImageView.af_setImage(withURL: restaurants[indexPath.row].coverImage.url)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (SCREEN_WIDTH-36) / CGFloat(restaurants[indexPath.row].coverImage.width)
            * CGFloat(restaurants[indexPath.row].coverImage.height) - 40
    }
}
